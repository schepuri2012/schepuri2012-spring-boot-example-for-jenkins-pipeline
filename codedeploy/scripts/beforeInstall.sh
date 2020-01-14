#!/bin/bash
APP_USER=ec2-user
SYM_LINK=jenkins-demo

echo "cd to the apps directory"
cd /home/$APP_USER/apps/

if [ -L ${SYM_LINK} ] ; then
    if [ -e ${SYM_LINK} ] ; then
        echo "Reading the target file of the existing symbolic link"
        target_file=`readlink -f $SYM_LINK` 
        echo $target_file


        echo "if the applicatio is running"
        echo "Stop the application"
        ./jenkins-demo/bin/jenkins-demo status
        ./jenkins-demo/bin/jenkins-demo stop
        
        echo "Back up previous application zip file"
        mv "${target_file}.zip" "${target_file}.zip.bkp"

        echo "Back up previous application folder"
        mv "${target_file}" "${target_file}.bkp" 
    fi
fi


if [ -L ${SYM_LINK} ] ; then
        echo "Removing the existing symbolic link"
        rm ${SYM_LINK}
fi
