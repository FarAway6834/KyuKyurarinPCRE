#!/bin/sh

# NOTE : it needs to dev and build in linux
# NOTE : I'll dev and build in github codespace

alias readfile="cat";

readfile $1 | perl initialc.pl > $2