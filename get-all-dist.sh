#!/bin/bash
find . -name Dockerfile -exec dirname {} \; | \
  grep -v -e 'stretch' -e 'bookworm' | \
  jq -R . | sed 's#./##g' | jq -cs .
