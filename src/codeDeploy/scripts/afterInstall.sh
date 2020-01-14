#!/bin/bash
APP_USER=ec2-user
SYM_LINK=jenkins-demo

cd /home/ec2-user/apps/
LATEST_ZIP=`ls -t *.zip | head -1`

if [ -f "$LATEST_ZIP" ]; then
    echo "$LATEST_ZIP exist"
    unzip $LATEST_ZIP
    echo ${LATEST_ZIP%.*}
    ln -s ${LATEST_ZIP%.*} $SYM_LINK
fi
