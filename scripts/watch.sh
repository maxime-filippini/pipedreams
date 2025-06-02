#!/usr/bin/env bash

(
  find lib   -type f -name "*.ex"
  find posts -type f -name "*.md"
) | entr -d -c mix site.build

