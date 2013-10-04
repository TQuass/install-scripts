#!/bin/bash
cd /home/ubuntu
source install-scripts/jobs/environment
search/bin/index.sh
sudo -u tomcat7 search/bin/snapshooter
