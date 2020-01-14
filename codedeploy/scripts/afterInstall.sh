#!/bin/bash
APP_USER=ec2-user
SYM_LINK=jenkins-demo

echo "cd to the apps directory"
cd /home/$APP_USER/apps/

echo "Reading the latest Zip filename"
LATEST_ZIP=`ls -t *.zip | head -1`
echo $LATEST_ZIP

if [ -f "$LATEST_ZIP" ]; then
    echo "$LATEST_ZIP exist"
    unzip $LATEST_ZIP
    chown -R ec2-user:ec2-user ${LATEST_ZIP%.*}
    echo "Creating symbolic link for ${LATEST_ZIP%.*}"
    ln -s ${LATEST_ZIP%.*} $SYM_LINK
fi
