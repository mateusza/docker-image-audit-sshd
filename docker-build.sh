#!/bin/bash

source docker-settings.conf

docker build --rm -t "$APP" .

