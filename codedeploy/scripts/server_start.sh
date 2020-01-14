#!/bin/bash

APP_USER=ec2-user

cd /home/$APP_USER/apps/ 
/bin/bash ./jenkins-demo/bin/jenkins-demo stop
/bin/bash ./jenkins-demo/bin/jenkins-demo start