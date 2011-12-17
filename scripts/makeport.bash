#!/usr/bin/env bash

cd /usr/ports/$1
echo making port in `pwd`
make install clean
echo done, leaving `pwd`

