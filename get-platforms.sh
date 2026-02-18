#!/bin/bash
supported=('linux/amd64')
if [[ ${GITHUB_REF:-} =~ refs/heads/([5-9])\.([0-9]+)\.[0-9]+ ]] ; then
  if [[ "${BASH_REMATCH[1]}" -ge 6 ]] && [[ "${BASH_REMATCH[2]}" -ge 1 ]] ; then
    supported+=('linux/arm64')
  fi
fi
printf '%s\n' "$(IFS=,; printf '%s' "${supported[*]}")"
