#!/usr/bin/env groovy

node('linux'){
    def node = tool name: 'Node11.13', type: 'jenkins.plugins.nodejs.tools.NodeJSInstallation'
    env.PATH = "${node}/bin:${env.PATH}"
    def npmGlobalPath = sh(script: 'npm bin -g', returnStdout: true).trim()
    env.PATH = "${npmGlobalPath}:${env.PATH}"

    stage('Checkout') {
        echo 'Pulling Branch: ' + env.BRANCH_NAME
        checkout scm
    }

    stage('Test Build') {
        sh "npm install"
        sh "rm -rf node_modules/"
    }

    def workspaceFolder = workspace.split('/')
    workspaceFolder = workspaceFolder.last()


    def remote = [:]
    remote.name = "192.168.1.92"
    remote.host = "192.168.1.92"
    remote.allowAnyHosts = true

    withCredentials([usernamePassword(credentialsId: 'nginx-username-password', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
        remote.user = USERNAME
        remote.password = PASSWORD
        
        stage('Build on Server and Deploy'){
            if(env.BRANCH_NAME == 'master'){     
                try {
                    sshCommand remote: remote, command: "mkdir /home/tks23/tmp"
                } catch(error) {
                    echo 'tmp Folder already exists'
                    try {
                        sshCommand remote: remote, command: "rm -rf /home/tks23/tmp/${workspaceFolder}"
                    } catch (err) {
                        echo 'Workspace folder does not exist yet'
                    }                    
                }

                sshPut remote: remote, from:".", into: "/home/tks23/tmp/"
                sshCommand remote: remote, command: "cd /home/tks23/tmp/${workspaceFolder} && npm i"
                sshCommand remote: remote, command: "rm -rf /home/tks23/projects/dinosaur-fact-api/*"
                sshCommand remote: remote, command: "cp -a /home/tks23/tmp/${workspaceFolder}/* /home/tks23/projects/dinosaur-fact-api/"
                sshCommand remote: remote, command: "cd /home/tks23/projects/dinosaur-fact-api/ && pm2 reload dino-facts-api"
                sshCommand remote: remote, command: "rm -rf /home/tks23/tmp/${workspaceFolder}"
            }else{
                echo 'Not deploying since not master branch'
            }
        }
   } 
}