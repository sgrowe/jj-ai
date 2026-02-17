#!/usr/bin/env bash
set -euo pipefail

description="$(jj log --no-graph -r @ -T 'description')"

if [ -z "$description" ]; then
  exit 0
fi

new_description="$(echo "$description" | sed '1s/^TODO: //')"

if [ "$new_description" != "$description" ]; then
  jj describe -m "$new_description"
fi
