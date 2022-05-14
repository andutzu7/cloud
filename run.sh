#!/bin/sh

rm -rf out

sh get_feeds.sh

sh insert_articles_in_db.sh

echo > templates/index.html

cat templates/template.html > templates/index.html

python app.py
