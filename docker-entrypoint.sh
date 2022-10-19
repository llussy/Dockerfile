#!/bin/bash

# https://stackoverflow.com/questions/53874301/how-to-run-command-when-container-is-started-docker
nginx && sleep 0.5s && /usr/local/bin/pm2 start /ecosystem.config.js & /usr/local/bin/pm2 log 

