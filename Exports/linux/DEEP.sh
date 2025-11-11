#!/bin/sh
echo -ne '\033c\033]0;DEEP\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/DEEP.x86_64" "$@"
