#!/usr/bin/env dash

free -h | grep Mem | awk '{print $3"/"$2}'
