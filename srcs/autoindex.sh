#!/bin/bash
conf_site='/etc/nginx/sites-available/site'
if grep -q "autoindex on" "$conf_site"
then
    sed -i "s/autoindex on/autoindex off/" "$conf_site"
    echo "Autoindex is OFF now!"
elif grep -q "autoindex off" "$conf_site"
then
    sed -i "s/autoindex off/autoindex on/" "$conf_site"
    echo "Autoindex is ON now!"
fi
service nginx restart