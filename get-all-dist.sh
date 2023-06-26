#!/bin/bash
find . -name Dockerfile -exec dirname {} \; | \
  grep -v -e 'stretch' | \
  jq -R . | sed 's#./##g' | jq -cs .
