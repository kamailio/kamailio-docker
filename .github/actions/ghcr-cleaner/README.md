# Github container registry cleaner
[![pylint](https://github.com/quartx-analytics/ghcr-cleaner/actions/workflows/pylint.yml/badge.svg)](https://github.com/quartx-analytics/ghcr-cleaner/actions/workflows/pylint.yml)

Action for deleting old containers from the Github container registry.

Deletes all truly untagged GHCR container images in a repository. Truly untagged images are images that
are not depended on by other tags. This can happen when using multiplatform packages.
Plus the newer versions of buildkit adds Provenance attestations witch add extra manifest data to each tagged image.
This shows up as 'unknown/unknown' in the github registry page. Most other GHCR cleaners don't take this into
account and can end up breaking tagged images.

This action can also be configured to keep at most a specified amount of tagged images, removing all others after the cut off.
The tags that are checked for removal can be controlled using tag filtering.


# Inputs

## `token`

**Required** Personal access token (PAT) used to fetch the repository. Needs `read:packages` and `delete:packages` permissions.

## `repository-owner`

The repository owner name. Default `${{ github.repository_owner }}`.

## `repository-name`

The repository name. Limits cleaning to only container images linked to the given repository.

## `package-name`

The package-name. Limits cleaning to image versions for the given package only.

## `owner-type`

**Required** Owner type (org or user).

## `delete-untagged`

Delete package versions that have no tags and are not a dependency of other tags. Default `true`.

## `keep-at-most`

Keep at most the given amount of image versions. Only applies to tagged images. Zero disables this feature. Default `0`.

## `filter-tags`

List of tags to filter for when using `--keep-at-most`. Accepts tags as Unix shell-style wildcards.

## `skip-tags`

List of tags to ignore when using `--keep-at-most`. Accepts tags as Unix shell-style wildcards.

## `dry-run`

Run the script without making any changes. Default `false`.


# Usage

#### Delete all truly untagged image versions from all packages for the given owner.
```yaml
- uses: quartx-analytics/ghcr-cleaner@v1
  with:
      owner-type: org # or user
      token: ${{ secrets.PAT_TOKEN }}
      repository_owner: ${{ github.repository_owner }}
      delete-untagged: true
```

#### Delete all truly untagged image versions with the given package name.
```yaml
- uses: quartx-analytics/ghcr-cleaner@v1
  with:
      owner-type: org # or user
      token: ${{ secrets.PAT_TOKEN }}
      repository_owner: ${{ github.repository_owner }}
      package-name: test-image
      delete-untagged: true
```

#### Only Keep the 5 most recent image versions, removing the rest. While also keeping untagged and only images related to given repository.
```yaml
- uses: quartx-analytics/ghcr-cleaner@v1
  with:
    owner-type: org # or user
    token: ${{ secrets.PAT_TOKEN }}
    repository_owner: ${{ github.repository_owner }}
    repository-name: ${{ github.repository }}
    delete-untagged: false
    keep-at-most: 5
```

#### Keep the 5 most recent image versions that start with "v" while ignoring some tags. And remove all truly untagged images.
```yaml
- uses: quartx-analytics/ghcr-cleaner@v1
  with:
      owner-type: org # or user
      token: ${{ secrets.PAT_TOKEN }}
      repository_owner: ${{ github.repository_owner }}
      package-name: test-image
      delete-untagged: true
      keep-at-most: 5
      filter-tags: v*
      skip-tags: latest,buildcache
```
