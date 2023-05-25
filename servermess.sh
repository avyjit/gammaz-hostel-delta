#!/usr/bin/env bash
echo Listening on port 8080...

while true;
  do echo \
   -e "HTTP/1.1 200 OK\n\n$(cat /home/HAD/mess.txt)" \
  | nc -l -k -p 8080 -q 1;
done