#!/bin/sh

# @@query@@ : https://www.hahwul.com?q="><script~~blahblah
# @@target@@ : https://www.hahwul.com
# @@type@@ : WEAK / VULN
# slack.sh @@query@@ @@type@@

query=$1
type=$2
if [ $type = "VULN" ]
then
  curl -X POST --data-urlencode "payload={\"channel\": \"#dalfox_xss\", \"username\": \"DalFox\", \"text\": \"[Verify]\n$query\", \"icon_emoji\": \"fox\"}" https://hooks.slack.com/services/XXXXXXXXXXX/XXXXXXXXXX
else
  curl -X POST --data-urlencode "payload={\"channel\": \"#dalfox_xss\", \"username\": \"DalFox\", \"text\": \"[Reflected]\n$query\", \"icon_emoji\": \":fox:\"}" https://hooks.slack.com/services/XXXXXXXXX/XXXXXXXXX
fi
