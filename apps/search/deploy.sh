#!/bin/bash
cd /home/ubuntu
repo="https://github.com/werelate/search.git"
install-scripts/apps/git.sh $repo search
cd search
cp /home/ubuntu/install-scripts/apps/search/indexer.properties conf
cp /home/ubuntu/install-scripts/apps/search/scripts.conf conf
cp /home/ubuntu/install-scripts/apps/search/logging.properties conf
# TODO this has got to go someday
sudo cp /home/ubuntu/install-scripts/apps/search/db_memcache.properties /var/lib/tomcat7/shared/classes
ant build
# assume index is at /mnt/index
cp -r dist/* /mnt/index
sudo cp solr/apache-solr-3.1.0.war /var/lib/tomcat7/webapps/solr.war
if ps ax | grep tomcat7 | grep -q -v grep; then
  sudo /etc/init.d/tomcat7 restart
fi
