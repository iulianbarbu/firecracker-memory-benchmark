#!/bin/bash

COUNT="${1:-1}" # Default to 4000

RES=scripts

chown -R iul:domain^users output

pushd $RES > /dev/null

./one-time-setup.sh
./setup-network-taps.sh 0 $COUNT 

popd > /dev/null

