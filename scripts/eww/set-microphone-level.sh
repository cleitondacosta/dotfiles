#!/usr/bin/env bash

DEFAULT_MIC_SOURCE="$(pacmd list-sources | grep "\* index:" | cut -d " " -f5)"

pactl set-source-volume "$DEFAULT_MIC_SOURCE" "$1"
