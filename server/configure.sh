#!/bin/bash
cd /home/ubuntu

# make directories
sudo mkdir -p /mnt/gedcom/ged && sudo chown www-data:www-data /mnt/gedcom/ged
sudo mkdir -p /mnt/gedcom/inprocess && sudo chown ubuntu:ubuntu /mnt/gedcom/inprocess
sudo mkdir -p /mnt/gedcom/xml && sudo chown ubuntu:ubuntu /mnt/gedcom/xml
sudo mkdir -p /mnt/gedcom/archive && sudo chown ubuntu:ubuntu /mnt/gedcom/archive
sudo mkdir -p /mnt/gedcom/export && sudo chown ubuntu:ubuntu /mnt/gedcom/export
sudo mkdir -p /mnt/images && sudo chown www-data:www-data /mnt/images
sudo mkdir -p /mnt/deleted-images && sudo chown www-data:www-data /mnt/deleted-images
sudo mkdir -p /var/log/mediawiki && sudo chown www-data:www-data /var/log/mediawiki
sudo mkdir -p /mnt/pages && sudo chown ubuntu:ubuntu /mnt/pages
sudo mkdir -p /var/log/gedcom && sudo chown ubuntu:ubuntu /var/log/gedcom
sudo mkdir -p /mnt/index/data/index
sudo chown ubuntu:ubuntu /mnt/index
sudo chown tomcat7:tomcat7 /mnt/index/data
sudo chown tomcat7:tomcat7 /mnt/index/data/index
# check if we can tighten this up a bit later
sudo mkdir -p /var/log/indexer && sudo chmod a+rwx /var/log/indexer
sudo mkdir -p /var/log/snapshooter && sudo chmod a+rwx /var/log/snapshooter
if ! [ -h search/logs ] ; then
  ln -s /var/log/snapshooter/ search/logs
fi

# deploy applications
install-scripts/apps/wiki/deploy.sh
install-scripts/apps/gedcom-review/deploy.sh
install-scripts/apps/wikidata/deploy.sh
install-scripts/apps/werelate-gedcom/deploy.sh
install-scripts/apps/search/deploy.sh

# copy various files to www
sudo cp install-scripts/server/robots.txt /var/www
sudo cp install-scripts/server/crossdomain.xml /var/www
sudo cp install-scripts/server/favicon.ico /var/www
# add php.ini modifications
sudo cp install-scripts/server/php_werelate.ini /etc/php5/conf.d

# enable website
if ! [ -h /etc/apache2/sites-enabled/werelate ]; then
  sudo a2ensite werelate
fi

# configure tomcat
if ! grep -q 'SEARCH OPTS' /etc/default/tomcat7; then
  sudo bash -c 'cat install-scripts/server/tomcat7.extra >> /etc/default/tomcat7'
fi
