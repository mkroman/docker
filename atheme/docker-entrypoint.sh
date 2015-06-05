#!/bin/sh
set -e

chown -R atheme .
pwd
exec gosu atheme /atheme/bin/atheme-services -n
