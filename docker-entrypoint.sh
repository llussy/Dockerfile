#!/bin/bash

nginx && sleep 0.5s && /usr/local/bin/pm2 start /ecosystem.config.js & /usr/local/bin/pm2 log 