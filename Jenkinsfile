#!/usr/bin/env groovy

node('linux'){
    // Clean Up
    stage('Clean Up') {
        try {
            sh "rm -rf *"
        } catch (Exception e) {}
        try {
            sh "rm .env .gitignore .npmrc .nvmrc"
        } catch (Exception e) {}
        try {
            sh "rm -rf .git"
        } catch (Exception e) {}
    }

    //  Add OC CLI
    stage('Add OC CLI') {
        def dir = pwd()
        sh "cp ~/jenkins/tools/oc-cli/oc ${dir}/"
        sh "./oc"
    }
    
    // OC Login
    stage('OC Login') {
        withCredentials([usernamePassword(credentialsId: 'oc-cli-mini', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
            sh "./oc login https://192.168.1.45:8443 -u ${USER} -p ${PASS} --insecure-skip-tls-verify"
        }
    }

     // OC Project
    stage('OC Project') {
        sh "./oc project dinosaur-facts"
    }

    // OC Start Build
    stage('OC Start Build') { 
        sh "./oc start-build dinosaur-fact-api --follow"
    }

    // OC Logout
    stage('OC Logout') { 
        sh "./oc logout"
    }

    // Clean Up
    stage('Clean Up') {
        try {
            sh "rm -rf *"
        } catch (Exception e) {}
        try {
            sh "rm .env .gitignore .npmrc .nvmrc"
        } catch (Exception e) {}
        try {
            sh "rm -rf .git"
        } catch (Exception e) {}
    }
}