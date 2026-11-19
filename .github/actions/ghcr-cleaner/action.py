#!/usr/bin/env python3

"""
GHCR untagged cleaner

Deletes all truly untagged GHCR containers in a repository. Tags that are not depended on by other tags
will be deleted. This scenario can happen when using multi arch packages.
"""

# Standard lib
from typing import Iterable, Any
from urllib.parse import urljoin
from operator import attrgetter
from datetime import datetime
import argparse
import fnmatch
import json
import sys
import os

# Third party
import requests
from dxf import DXF
from colorama import Fore


def str2bool(value: str) -> bool:
    """Utility to convert a boolean string representation to a boolean object."""
    if str(value).lower() in ("yes", "true", "y", "1", "on"):
        return True
    elif str(value).lower() in ("no", "false", "n", "0", "off"):
        return False
    else:
        raise argparse.ArgumentTypeError("Boolean value expected.")


class ArgList(argparse.Action):
    """
    Handle a list of values passed in from GitHub actions.
    There are a few different ways that a list of values can be passed.

    Options are:
        * value1,value2
        * value1, value2
        * [value1, value2]
        * |
          value1
          value2

    We use an action to do this cause spaces causes issues. And we need to use nargs * witch
    collects the values with spaces as a list. This class handles that case.
    """

    # noinspection PyMethodOverriding
    def __call__(self, _, namespace, values, __):
        # Convert from list back to string for easier parsing
        value = ",".join(values).strip("[").strip("]")
        value = list(filter(None, map(str.strip, value.replace("\n", ",").split(","))))
        setattr(namespace, self.dest, value)


def get_args():
    """Get all arguments passed into this script."""
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--token", type=str, required=True,
        help="Github Personal access token with delete:packages permissions",
    )
    parser.add_argument(
        "--repo-owner", type=str.lower, required=True,
        help="The repository owner name",
    )
    parser.add_argument(
        "--repo-name", type=str.lower, required=False, nargs="?", const="", default="",
        help="Delete containers only from this repository",
    )
    parser.add_argument(
        "--package-name", type=str.lower, required=False, nargs="?", const="", default="",
        help="Delete only package name",
    )
    parser.add_argument(
        "--owner-type", type=str.lower, choices=["org", "user"], default="org",
        help="Owner type (org or user)",
    )
    parser.add_argument(
        "--dry-run", type=str2bool, default=False,
        help="Run the script without making any changes.",
    )
    parser.add_argument(
        "--delete-untagged", type=str2bool, default=True,
        help="Delete package versions that have no tags and are not a dependency of other tags.",
    )
    parser.add_argument(
        "--keep-at-most", type=int, default=5,
        help="Keep at most the given amount of image versions. Only applies to tagged image versions.",
    )
    parser.add_argument(
        "--filter-tags", action=ArgList, nargs="*",
        help="List of tags to filter for when using --keep-at-most. Accepts tags as Unix shell-style wildcards.",
    )
    parser.add_argument(
        "--skip-tags", action=ArgList, nargs="*",
        help="List of tags to ignore when using --keep-at-most. Accepts tags as Unix shell-style wildcards.",
    )

    args = parser.parse_args()

    # GitHub offers the repository as an owner/repo variable
    # So we need to handle that case
    if "/" in args.repo_name:
        owner, repo_name = args.repo_name.lower().split("/")
        if owner != args.repo_owner:
            msg = f"Mismatch in repository: {args.repo_name} and owner:{args.repo_owner}"
            raise ValueError(msg)
        args.repo_name = repo_name

    # Strip any leading or trailing '/'
    args.package_name = args.package_name.strip("/")
    return args


_args = get_args()
PER_PAGE = 100
DOCKER_ENDPOINT = "ghcr.io"
GITHUB_API_URL = os.environ.get("GITHUB_API_URL", "https://api.github.com")
GITHUB_TOKEN = _args.token
DRY_RUN = _args.dry_run


def request_github_api(url: str, method="GET", **options) -> requests.Response:
    """Make web request to GitHub API, returning response."""
    url = urljoin(GITHUB_API_URL, url)
    return requests.request(
        method, url,
        headers={
            "X-GitHub-Api-Version": "2022-11-28",
            "Accept": "application/vnd.github+json",
            "Authorization": f"Bearer {GITHUB_TOKEN}",
        },
        timeout=options.pop("timeout", 10),
        **options
    )


def get_paged_resp(url: str, params: dict[str, Any] = None) -> Iterable[dict]:
    """Return an iterator of paged results, looping until all resources are collected."""
    params = params or {}
    params.update(page="1")
    params.setdefault("per_page", min(PER_PAGE, 100))

    while True:
        resp = request_github_api(url, params=params)
        resp.raise_for_status()
        yield from resp.json()

        # Continue with next page if one is found
        if "next" in resp.links:
            url = resp.links["next"]["url"]
            params.pop("page", None)
        else:
            break


class Version:
    """Class for each version of a docker registry package."""
    def __init__(self, pkg: "Package", version):
        self.version = version
        self.pkg = pkg

    @property
    def id(self):
        """Return the version ID."""
        return self.version["id"]

    @property
    def digest(self) -> str:
        """Return the sha256 digest of the image version."""
        return self.version["name"]

    @property
    def date(self) -> datetime:
        """Return the date the version was created/updated."""
        created = self.version["updated_at"].replace("Z", "+00:00")
        return datetime.fromisoformat(created)

    @property
    def tags(self) -> list[str]:
        """Return list of tags for this version."""
        return self.version["metadata"]["container"]["tags"]

    def match_tags(self, patterns) -> bool:
        """Return True if any of the patterns match any tags using glob matching, else False."""
        for pattern in patterns:
            if fnmatch.filter(self.tags, pattern):
                return True
        return False

    def get_deps(self) -> list[str]:
        """Return list of untagged images that this version depends on."""
        if self.tags:
            manifest = self.pkg.registry.get_manifest(self.digest)
            manifest = json.loads(manifest)
            return [arch["digest"] for arch in manifest.get("manifests", [])]
        else:
            return []

    def delete(self):
        """Delete this image version from the registry."""
        print(Fore.YELLOW + "Deleting" + Fore.RESET, f"{self.digest}:", end=" ")
        if DRY_RUN:
            print(Fore.GREEN + "Dry Run" + Fore.RESET)
            return True

        try:
            resp = request_github_api(self.version["url"], method="DELETE")
        except requests.RequestException as err:
            print(err.response.reason if err.response else "Fatal error")
            return False
        else:
            print(Fore.GREEN + "OK" + Fore.RESET if resp.status_code == 204 else Fore.RED + resp.reason + Fore.RESET)
            return resp.ok

    def __hash__(self):
        return hash(self.id)

    def __eq__(self, other):
        if isinstance(other, self.__class__):
            return self.id == other.id
        return False


class Package:
    """Class for each package on the registry."""
    def __init__(self, owner: str, pkg_data):
        self.pkg = pkg_data
        self.owner = owner

        self.registry = DXF(
            DOCKER_ENDPOINT,
            repo=f"{self.owner}/{self.name}",
            auth=lambda dxf, resp: dxf.authenticate(owner, GITHUB_TOKEN, response=resp)
        )

    @property
    def name(self) -> str:
        """Return the package name."""
        return self.pkg["name"]

    @property
    def version_url(self) -> str:
        """Rest url to package versions."""
        url = self.pkg["url"]
        return f"{url}/versions"

    def get_versions(self) -> Iterable["Version"]:
        """Iterable of package versions."""
        for version in get_paged_resp(self.version_url):
            yield Version(self, version)

    @classmethod
    def get_all_packages(cls, owner_type: str, owner: str, repo_name: str, package_name: str) -> Iterable["Package"]:
        """Return an iterator of registry packages."""
        path = f"/{owner_type}s/{owner}/packages?package_type=container"
        for pkg in get_paged_resp(path):
            if repo_name and pkg.get("repository", {}).get("name", "").lower() != repo_name.lower():
                continue

            if package_name and pkg["name"] != package_name:
                continue

            yield cls(owner, pkg)


def bulk_delete(delete_list: Iterable[Version]) -> int:
    """Take a give list of image version to delete and delete them."""
    status_counts = [0, 0]  # [Fail, OK]
    for unwanted_version in delete_list:
        status = unwanted_version.delete()
        status_counts[status] += 1

    print("")
    print(status_counts[1], Fore.GREEN + "Deletions" + Fore.RESET)
    print(status_counts[0], Fore.RED + "Errors" + Fore.RESET)
    return bool(status_counts[0])


def run() -> Iterable[Version]:
    """Scan the GitHub container registry for untagged image versions."""
    # Get list of all packages
    all_packages = Package.get_all_packages(
        owner=_args.repo_owner,
        repo_name=_args.repo_name,
        package_name=_args.package_name,
        owner_type=_args.owner_type,
    )

    for pkg in all_packages:
        unwanted = set()
        tagged, untagged = [], []
        print(Fore.CYAN + "Processing package:", Fore.BLUE + pkg.name + Fore.RESET, end="... ")
        for version in pkg.get_versions():
            if version.tags:
                tagged.append(version)
            else:
                untagged.append(version)

        tag_count = len(tagged)
        # Keep the most recent image versions of the given amount
        # We Need to filter out the old tags first, before we attempt deleting any untagged images
        if _args.keep_at_most > 0:
            sortable_list = []
            for version in tagged:
                # Skip if we have skip tags, and we find a match
                if _args.skip_tags and version.match_tags(_args.skip_tags):
                    continue

                # Skip if we have filter tags, and we do not find a match
                if _args.filter_tags and not version.match_tags(_args.filter_tags):
                    continue

                sortable_list.append(version)

            # Remove all old versions after the most recent count is hit
            sorted_tagged = sorted(sortable_list, key=attrgetter("date"), reverse=True)
            for count, version in enumerate(sorted_tagged, start=1):
                if count > _args.keep_at_most:
                    unwanted.add(version)

            # We will want to reset the tagged list here, to stop delete_untagged from scanning unwanted versions
            tagged = [version for version in tagged if version not in unwanted]

        # Delete untagged versions
        if _args.delete_untagged:
            tag_dependencies = set()
            # Build set of dependencies
            for version in tagged:
                deps = version.get_deps()
                tag_dependencies.update(deps)

            # Collect list of all untagged versions that are not dependencies of other versions
            unwanted.update(version for version in untagged if version.digest not in tag_dependencies)

        print(
            f"({Fore.GREEN + 'total' + Fore.RESET}={tag_count + len(untagged)},",
            f"{Fore.GREEN + 'tagged' + Fore.RESET}={tag_count},",
            f"{Fore.GREEN + 'untagged' + Fore.RESET}={len(untagged)},",
            f"{Fore.GREEN + 'unwanted' + Fore.RESET}={len(unwanted)})",
        )
        yield from unwanted


if __name__ == "__main__":
    try:
        _delete_list = run()
        exit_code = bulk_delete(_delete_list)
        sys.exit(exit_code)
    except KeyboardInterrupt:
        sys.exit(130)
