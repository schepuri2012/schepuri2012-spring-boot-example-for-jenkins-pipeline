#!/bin/bash
APP_USER=ec2-user
SYM_LINK=jenkins-demo

cd /home/ec2-user/apps/
target_file=`readlink -f $SYM_LINK` 

echo $SYM_LINK
echo $target_file


if [ -L ${SYM_LINK} ] ; then
    if [ -e ${SYM_LINK} ] ; then
        rm ${SYM_LINK}
    fi
fi
