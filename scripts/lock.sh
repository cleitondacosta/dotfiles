#!/usr/bin/env bash

BG_IMAGE_FILE="$(cat ~/.fehbg | grep -o "'.*'" | sed "s/'//g")"

i3lock -ti "$BG_IMAGE_FILE"
