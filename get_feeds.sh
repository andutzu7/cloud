#!/bin/sh

feeds_list=feeds_list

rm -rf out
mkdir out

while IFS="" read -r p || [ -n "$p" ]
do
	sh parseRssFeed.sh $(echo $p | sed -e 's/www.//g') > out/$(echo $p | sed 's/^.*\(www.*ro\).*$/\1/' | sed -e 's/www.//g');
done < $feeds_list
