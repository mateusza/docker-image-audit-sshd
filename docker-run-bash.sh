#!/bin/bash

set -e

source docker-settings.conf

echo "Running"

opts=(
    -i
    -t
    -v /sys/fs/cgroup:/sys/fs/cgroup:ro
    -v "$(pwd)/test-users:/users:ro"
    -v "/tmp:/xxx-tmp:ro"
    "$APP"
    /bin/bash
)

docker run "${opts[@]}"
