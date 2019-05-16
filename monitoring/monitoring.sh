#!/bin/bash
# Very basic bash script to monitor HTTP. 
# Add your email in to the list seperated by a , if you want to test it.

# list of sites
SITESFILE=/tmp/monitoring/sites.txt
# list of email addresses to receive alerts
EMAILS="rosswilliams4@gmail.com" 

while read site; do
    if [ ! -z "${site}" ]; then
    
        if curl -s --head --request GET $site | grep "200 OK" > /dev/null
        then
            echo "The HTTP server on ${site} is up"
        else    
            MESSAGE="This is an alert that ${site} has failed to respond 200 OK."
            for EMAIL in $(echo $EMAILS | tr "," " "); do
                SUBJECT="$site (http) Failed"
                echo "$MESSAGE" | mail -s "$SUBJECT" $EMAIL
                echo $SUBJECT
                echo "Alert sent to $EMAIL"
            done      
        fi
    fi
done < $SITESFILE