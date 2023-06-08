#!/usr/bin/env bash

DEFAULT_MIC_SOURCE="$(pacmd list-sources | grep "\* index:" | cut -d " " -f5)"
VOLUME=$(\
    pacmd list-sources\
    | grep "index: $DEFAULT_MIC_SOURCE" -A 7\
    | grep "volume"\
    | awk -F "/" '{print $2}'\
    | tr -d "%"\
)

echo $VOLUME
