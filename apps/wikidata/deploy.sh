#!/bin/bash
cd /home/ubuntu
repo="https://github.com/werelate/wikidata.git"
install-scripts/apps/git.sh $repo wikidata
cd wikidata
ant build
