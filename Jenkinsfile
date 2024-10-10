pipeline {
    agent any 
    stages {
        // create stage 1 for fetching git repo info 
        stage('fetching git repo details'){
            // steps 
            steps {
                echo 'fetching git repo'
                git branch: 'springboot', url:'https://github.com/udaybuilds/unisys_devsecops.git'
                sh 'ls'
            }
            
        }
        // creating second stage for doing SAST analysis for any Critical bugs
        stage('SAST using trivy for Critical vulns'){
            steps {
                echo 'using trivy to scan code pushed by developer'
                sh 'trivy  fs --scanners  vuln,secret,misconfig  .'
            }
        }

    }
}
