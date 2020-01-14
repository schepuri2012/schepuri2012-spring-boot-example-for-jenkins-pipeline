#!/usr/bin/env groovy
pipeline {
    agent any

    environment {
        NEXUS_REPOSITORY_USERNAME = credentials('NEXUS_REPOSITORY_USERNAME')
        NEXUS_REPOSITORY_PASSWORD = credentials('NEXUS_REPOSITORY_PASSWORD')
        JENKINS_IMMPORT_AWS_ACCESS_KEY = credentials('JENKINS_IMMPORT_AWS_ACCESS_KEY')
        JENKINS_IMMPORT_AWS_SECRET_KEY = credentials('JENKINS_IMMPORT_AWS_SECRET_KEY')
    }

    triggers {
        pollSCM('H/1 * * * *')
    }

    options { disableConcurrentBuilds() }
    
    stages {
        stage('clean') {
            steps {
                sh './gradlew --no-daemon clean'
            }
        }
        stage('Build') {
            steps {
                sh './gradlew --no-daemon build -x test'
            }
        }
        stage('Test') {
            steps {
                sh './gradlew --no-daemon test'
            }
        }        
        stage('Publish to Nexus') {
            steps {
                sh './gradlew --no-daemon publishArtifactPublicationToRemoteRepository'
            }
        }
        stage('AWS Codedeploy') {
            steps {
                
			    withCredentials([
                    string(credentialsId: 'JENKINS_IMMPORT_AWS_ACCESS_KEY', variable: 'codeDeployAccessKey'),
                    string(credentialsId: 'JENKINS_IMMPORT_AWS_SECRET_KEY', variable: 'codeDeploySecretKey')]) {

                    // script {
                    //     def codeDeployAccessKey = codeDeployAccessKey;
                    //     def codeDeploySecretKey = codeDeploySecretKey; 
                    // }

                    step([
                        $class: 'AWSCodeDeployPublisher', 
                        applicationName: 'spring-boot-example-for-jenkins-pipeline', 
                        awsAccessKey: codeDeployAccessKey, 
                        awsSecretKey: codeDeploySecretKey, 
                        credentials: 'awsAccessKey', 
                        deploymentConfig: 'CodeDeployDefault.OneAtATime', 
                        deploymentGroupAppspec: false, 
                        deploymentGroupName: 'spring-boot-example-for-jenkins-pipeline-DepGrp', 
                        excludes: '', 
                        iamRoleArn: '', 
                        includes: 'codedeploy/**', 
                        proxyHost: '', 
                        proxyPort: 0, 
                        region: 'us-east-2', 
                        s3bucket: 'cicdstackdemo-codedeploybucket-1xm7w2kefj6ku', 
                        s3prefix: 'immport-codedeploy', 
                        subdirectory: '', 
                        versionFileName: 'schepuri', 
                        waitForCompletion: true
                    ])		

		        }
            }
        }
    }
}