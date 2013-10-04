#!/bin/bash
cd /home/ubuntu
repo="git@github.com:werelate/wiki.git"
install-scripts/apps/git.sh $repo wiki
sudo mkdir -p /var/www/w && sudo chown ubuntu:ubuntu /var/www/w
rsync -a --exclude '.git' wiki/ /var/www/w/
sudo cp install-scripts/apps/wiki/werelate /etc/apache2/sites-available
