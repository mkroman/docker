#!/bin/sh
set -e

pwd
chown -R atheme .
exec gosu atheme /atheme/bin/atheme-services -n
