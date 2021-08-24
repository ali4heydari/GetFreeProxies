# GetFreeProxies
Multithreaded bash script for get and check free proxies
## Dependencies
+ Python 3.6+
## Usage
```bash
$ git clone https://github.com/ali4heydari/GetFreeProxies.git && cd GetFreeProxies/
$ chmod +x getFreeProxy.sh
$ ./getFreeProxy.sh
```
for output only good proxies:
```bash
$ ./getFreeProxy.sh | awk '/good/ {print $1}'
```

## 💥 NEW: Telegram Mtproto proxy
This script get's Mtproto proxies from [this](https://github.com/hookzof/socks5_list) repo and outputs in Telegram proxy format

### Usage
```bash
$ ./getMtprotoProxy.sh
```
proxies sorted by ping so for example to get top 5 proxies with lowest ping:
 
 ```bash
$ ./getMtprotoProxy.sh | head -n5
```

## 💥 NEW: GUI 
In order to use the proxy on desktop, the GUI generates QR codes which can be used to scan on other devices.

### Install
```bash
$ pip install -r requirements.txt
```

### usage
 ```bash
$ python gui.py
```
