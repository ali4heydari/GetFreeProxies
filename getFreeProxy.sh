#!/bin/bash

PROXY_TYPE='http'
CHECK_URL='https://twitter.com'
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

function GetFreeProxys() {
  curl -s 'https://raw.githubusercontent.com/clarketm/proxy-list/master/proxy-list-raw.txt' && \
  curl -s 'https://raw.githubusercontent.com/TheSpeedX/SOCKS-List/master/http.txt' && \
  curl -s 'https://raw.githubusercontent.com/fate0/proxylist/master/proxy.list' 2>&1 | \
  tr '\n' ',' | \
  ( read -r badJson; echo "[${badJson:0:-1}]" ) | \
  python3 -c "import sys, json;array = json.load(sys.stdin);array = list(filter(lambda x: x['type'] == 'https' or x['type'] == 'http', array)); [ print(proxy['host'],proxy['port'],sep=':') for proxy in array];"
}

for PROXY in `GetFreeProxys`
do
  (unset USER PASS
  IP=$(echo $PROXY | awk -F: '{print $1}')
  PORT=$(echo $PROXY | awk -F: '{print $2}')
  USER=$(echo $PROXY | awk -F: '{print $3}')
  PASS=$(echo $PROXY | awk -F: '{print $4}')

  if [[ $USER && $PASS ]]
  then
    CHECK=`curl -s -I -m $MAX_CONNECT $PROXY_TYPE_COMMAND $IP:$PORT -U $USER:$PASS $CHECK_URL | head -n 1 | awk '{print $2}'`

  else
    CHECK=`curl -s -I -m $MAX_CONNECT $PROXY_TYPE_COMMAND $IP:$PORT $CHECK_URL | head -n 1 | awk '{print $2}'`
  fi

  if [[ $CHECK -eq "200" ]]
  then
    echo -e $TUR"$PROXY is good"$DEF
  else
    echo -e $RED"$PROXY is dead"$DEF
  fi) &
done
