#!/bin/bash

set -e

# change the config file

sed -i -e "s/\(REDIS_HOST:\).*/\1 redis/"  \
       -e "s/\(MAX_CONTENT_LENGTH:\).*/\1 $MAXSIZE/" config.local.yml

exec "$@"
