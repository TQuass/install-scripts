#!/bin/bash
cd /home/ubuntu
source install-scripts/jobs/environment
php wiki/maintenance/updateSpecialPages.php
