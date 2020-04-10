#!/bin/bash
# https://medium.com/@jfroom/docker-compose-3-bundler-caching-in-dev-9ca1e49ac441
# Interpreter identifier

set -e

# https://robots.thoughtbot.com/parallel-gem-installing-using-bundler
number_of_cores=`nproc`
bundle check || bundle install -j"$number_of_cores"  --binstubs="$BUNDLE_BIN"

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

exec "$@"
# Finally call command issued to the docker service
