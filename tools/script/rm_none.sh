#!/bin/bash
NONE_ID=$(docker images | grep "<none>" | cut -d ' ' -f 28)
CON_ID=$(docker ps -a | grep "$NONE_ID" | cut -d ' ' -f 1)
docker rm "$CON_ID"
docker rmi "$NONE_ID"
