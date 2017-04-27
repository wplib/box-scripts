#!/usr/bin/env bash

echo "Switching object cache to $1"

if [ ! "redis" == "$1" ] && [ ! "memcached" == "$1" ]; then
    echo 'You must select either redis or memcached'
    exit 1
fi

converse="memcached"
if [ 'memcached' == $1 ]; then
    converse='redis'
fi

docker stop $converse 2>&1 > /dev/null \
  && docker start $1 2>&1 > /dev/null \
  && sudo sudo sed -i "s/${converse}/$1/" /vagrant/project.json