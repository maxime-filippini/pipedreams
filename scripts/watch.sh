#!/usr/bin/env bash

(
  find lib   -type f -name "*.ex"
  find posts -type f -name "*.md"
  echo ./assets/tailwind.config.js
) | entr -d -c mix site.build

