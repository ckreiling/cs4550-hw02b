#!/bin/bash

export MIX_ENV=prod
export PORT=4790
export HOME=/home/kreiling/hw02b/_build

echo "Stopping old copy of app, if any..."

_build/prod/rel/practice/bin/practice stop || true

echo "Starting app..."

_build/prod/rel/practice/bin/practice start
