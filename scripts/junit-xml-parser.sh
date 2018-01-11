#! /bin/bash

#
# Simple formatter for JUnit xml reports generated by Maven Surefire
#

filename="$1"

# use `grep` to look for failures oder exceptions
fullResult=$(cat "$filename" | grep -E "(<failure|<error)" -A1 -B1)

# replace the line "<testcase... " with the test methods name
result=$(echo "$fullResult" | sed -r 's/^\s*<testcase classname="([^"]+)" name="([^"]+)" time="([^"]+)">/- \2\t(\3s)/g')

# replace failure tag
result=$(echo "$result" | sed -r 's/^\s*<failure message="([^"]+)" type="([^"]+)">/  FAIL:\t/g')

# replace exception tag
result=$(echo "$result" | sed -r 's/^\s*<error type="([^"]+)">/  ERR:\t/g')

# replace HTML-Entities
result=$(echo "$result" | sed -r 's/&lt;/</g;s/&gt;/>/g')

# replace grep's group separator `--`
result=$(echo "$result" | sed '/^--/d')

echo "$result"
