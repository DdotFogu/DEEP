#!/bin/sh
printf '\033c\033]0;%s\a' DEEP
base_path="$(dirname "$(realpath "$0")")"
"$base_path/DEEP.x86_64" "$@"
