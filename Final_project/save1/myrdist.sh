#!/bin/sh
# A preconfigured rdist that uses ssh
SSH="`which ssh`"
RDISTD="`which rdistd`"

rdist -p "$RDISTD" -P "$SSH" "$@"
