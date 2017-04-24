#!/usr/bin/env bash

database="$(jq '.startup.database' < /vagrant/box.json)"
webserver="$(jq '.startup.webserver' < /vagrant/box.json)"
processvm="$(jq '.startup.processvm' < /vagrant/box.json)"

docker start $database \
  && docker start $webserver \
  && docker start $processvm