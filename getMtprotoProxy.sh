#!/bin/bash

PROXY_TYPE='http'
CHECK_URL='https://t.me'
MAX_CONNECT=10
PROXY_TYPE_COMMAND="--proxy"

# COLORS #
RED='\033[1;31m'
BLUE='\033[1;34m'
TUR='\033[1;36m'
YEL='\033[1;33m'
DEF='\033[0m'
# END OF COLORS #


# CHECK CURL IF EXIST #
if ! which curl > /dev/null
then
  echo -e $RED"curl not found"$DEF
  exit 1
fi
# END OF CHECK CURL IF EXIST #

function GetMtprotoProxy() {
  curl -s 'https://raw.githubusercontent.com/hookzof/socks5_list/master/tg/mtproto.json' 2>&1 | \
  python3 -c "import sys, json;array = json.load(sys.stdin); array.sort(key=lambda x: x['ping']); [ print(f'https://t.me/proxy?server={proxy[\"host\"]}&port={proxy[\"port\"]}&secret={proxy[\"secret\"]}') for proxy in array];"
}

GetMtprotoProxy
