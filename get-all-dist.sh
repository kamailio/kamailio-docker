#!/bin/bash
find . -name Dockerfile -exec dirname {} \; | grep -v 'stretch'| jq -R . | sed 's#./##g' | jq -cs .
