#!/bin/bash

# When we start the docker container, we run the servermess.sh
# script to serve the mess.txt file. However this blocks the terminal
# and we cannot run any other commands. So we run it in the background
# and then start an interactive shell for users to run commands.

nohup /scripts/servermess.sh &
exec /bin/bash
