#!/bin/bash
cd /home/ubuntu
repo="git@github.com:werelate/werelate-gedcom.git"
install-scripts/apps/git.sh $repo werelate-gedcom
cd werelate-gedcom
cp /home/ubuntu/install-scripts/apps/werelate-gedcom/gedcom.properties conf
ant build
