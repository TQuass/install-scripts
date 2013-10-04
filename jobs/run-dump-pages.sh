#!/bin/bash
cd /home/ubuntu
source install-scripts/jobs/environment
php -q wiki/maintenance/dumpBackup.php --current --quiet > /mnt/pages/pages.xml
