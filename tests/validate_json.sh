#!/bin/bash
# Test script to validate JSON file
# ===============================================
# Basically this script is aimed to run on Docker
# container via docker-compose.

# Target file
name_file=${name_file:-list_url_feeds_nice.json}

# Check gofeed-cli instalation
echo -n '- Check gofeed-cli ... '
which gofeed-cli > /dev/null
if [ $? -ne 0 ]; then
    echo 'NG'
    echo 'You need gofeed-cli to be installed.'
    exit 1
fi
echo 'OK (installed)'

# Check jq instalation
echo -n '- Check jq ... '
which jq > /dev/null
if [ $? -ne 0 ]; then
    echo 'NG'
    echo '* You need jq to be installed.'
    exit 1
fi
echo 'OK (installed)'

echo '========================'
echo ' VALIDATION TESTS BEGIN'
echo '========================'

echo "- Target file: ${name_file}"

# Check JSON Format
echo -n '- Check JSON format ... '
cat ./$name_file | jq . > /dev/null
if [ $? -ne 0 ]; then
    echo '* Malformed JSON in' $name_file
    exit 1
fi
echo 'OK (Valid JSON format)'

# Check Duplicate URL
echo -n '- Check URL duplicate ... '
diff <(cat $name_file | jq -r 'sort_by(.url) | [.[].url]') <(cat $name_file | jq -r '[.[].url] | unique')
if [ $? -ne 0 ]; then
    echo '* Duplicate URL found'
    exit 1
fi
echo 'OK (No duplicate URL found)'

# Check item order (Sorted by URL)
echo -n '- Check order of the items ... '
diff <(cat $name_file | jq '. | sort_by(.url)') <(cat $name_file | jq .)
if [ $? -ne 0 ]; then
    echo '* Invalid order detected.'
    echo 'Please sort items by URL. Prefered order are as below:'
    cat $name_file | jq '. | sort_by(.url)'
    exit 1
fi
echo 'OK (Well sorted by URL)'

# Check Feed Format
echo '- Check feed format from the URLs:'
list=$(cat $name_file | jq -r '.[].url')
for url in $list
do
    gofeed-cli url $url > /dev/null
    if [ $? -ne 0 ]; then
       echo 'NG :' $url
       echo '* Can NOT parse the feed from given url.'
       exit 1
    fi
    echo 'OK :' $url
done
echo '   - All feed URLs are valid to use with gofeed-cli command.'

echo
echo 'ALL TESTS PASSED. READY TO PR or MERGE.'
exit 0
