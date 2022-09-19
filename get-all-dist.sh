#!/bin/bash
find . -name Dockerfile -exec dirname {} \; | jq -R . | sed 's#./##g' | jq -cs .