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