#!/usr/bin/env bash

file_name=~/.myrice/lists/quotes.txt
file_content="$(cat "$file_name")"

number_of_lines="$(echo "$file_content" | wc -l)"
random_line_number=$(($RANDOM % $number_of_lines))
random_line_number=$(($random_line_number + 1))
random_line="$(echo "$file_content" | awk "NR == $random_line_number {print}")"

echo -e "$random_line"
