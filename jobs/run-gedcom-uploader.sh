#!/bin/bash
# exit if we're already running
if ps x | grep org.werelate.gedcom.Uploader | grep -q -v grep; then
  exit 0
fi
cd /home/ubuntu
source install-scripts/jobs/environment
cd werelate-gedcom/shell
./werelate-gedcom.sh >> /var/log/gedcom/gedcom.log 2>&1
