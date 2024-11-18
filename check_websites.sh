#!/bin/bash

websites=("https://google.com" "https://facebook.com" "https://twitter.com")
log_file="website_status.log"

> "$log_file"

echo "Starting website status check..."
echo "Results will be logged in $log_file"

for website in "${websites[@]}"; do
    if [[ -z "$website" ]]; then
        echo "Skipping empty website entry"
        continue
    fi

    echo "Checking website: $website"

    website_response=$(curl -o /dev/null -s -w "%{http_code}" -L "$website" | tr -d '\r\n' | xargs)
    echo "Raw response: '$website_response' (length: ${#website_response})"

    if [[ "$website_response" == "200" ]]; then
        echo "Comparing: $website_response == 200 => is UP"
        status="is UP"
    else
        echo "Comparing: $website_response != 200 => is DOWN"
        status="is DOWN"
    fi

    echo "<$website> $status" >> "$log_file"
done

echo "Website status check completed."
echo "Results have been logged in $log_file"
# 