#!/bin/sh
#Megasaturnv 2017-07-28
# Original author https://gist.github.com/megasaturnv/fba1b2f81cdb1d6ac63b73cf0eb839a6
#Url of the RSS feed
RSS_URL=$1
##Commented version:
#Download the rss feed
curl --silent "$RSS_URL" | \

#Only match lines with 'title>' or 'description>'
grep -E '(title>)' | \

#Remove the first 3 lines
tail -n +4 | \
#Other methods which use sed instead of tail
  #sed -n '4,$p' | \
  #sed -e '1,3d' | \

#Remove all leading whitespace from each line (spaces and tabs)
sed -e 's/^[ \t]*//' | \

#Remove all title and description tags. '<description>' is replaced with '  ' to indent it
sed -e 's/<title>//' -e 's/<\/title>//' -e 's/<description>/  /' -e 's/<\/description>//' | \

sed -e 's/<!//g'  -e 's/\[\CDATA//g' -e 's/\]>//g' -e 's/\]//g' -e 's/\[//g'
