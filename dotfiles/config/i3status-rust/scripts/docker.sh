#!/usr/bin/env dash
# Display the number of running docker containers

COUNT="$(docker ps -q | wc -l)"

echo "{\"text\": \" \uf21f  $COUNT\"}"
