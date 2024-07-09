#!/usr/bin/env bash

START_LINE="$(pacmd list-sources | awk '/* index/ { print NR; exit }')"

if [ -z "$START_LINE" ]; then
    echo "Default source not found."
    exit 1
fi

END_LINE=$(pacmd list-sources | awk "NR > $START_LINE && /index/ { print NR; exit }")

[[ -z $END_LINE ]] && END_LINE="$(pacmd list-sources | wc -l)"

MIC_NAME=$(pacmd list-sources | awk "NR > $START_LINE && NR < $END_LINE { print }" | grep product.name | awk -F '=' '{ print $2 }' | tr -d '"')

if [ -z "$MIC_NAME" ]; then
    echo "Microphone name not found."
else
    echo $MIC_NAME
fi
