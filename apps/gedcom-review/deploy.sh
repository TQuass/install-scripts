#!/bin/bash
cd /home/ubuntu
repo="git@github.com:werelate/gedcom-review.git"
install-scripts/apps/git.sh $repo gedcom-review
cd gedcom-review
cp /home/ubuntu/install-scripts/apps/gedcom-review/build.properties .
ant build
sudo mkdir -p /var/www/gedcom
sudo chown ubuntu:ubuntu /var/www/gedcom
cp -r out/* /var/www/gedcom
