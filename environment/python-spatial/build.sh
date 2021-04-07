#!/bin/bash

#
# copy extra functions
#
cp ../../library/setup.py .
cp -R ../../library/rep_cbers_cube .

#
# build!
#
docker build -t "m3nin0/rep-cbers-dc-python:0.1" .

#
# remove temp folder
#
rm -rf setup.py rep_cbers_cube
