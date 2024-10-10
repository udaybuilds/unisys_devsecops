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
        // using compsoe to build and test
        stage('building image with compose'){
            steps {
                echo 'running docker compose'
                sh 'docker-compose down'
                sh 'docker-compose up -d --build'
                sh 'docker-compose ps'
            }
        }
        // pushing image to dockerhub 
        stage('image rebuild and push'){
            steps {
                echo 'using docker pipeline plugin to build and push image'
                script {
                    def imageName = "udaysivastava/udayjava"
                    def imageTag  = "tomcatdeploy$BUILD_NUMBER"
                    def udayCred = "022f51eb-8008-44b9-9a9e-190b3ae70c36"
                    // building image 
                    docker.build(imageName + ":" + imageTag , " -f Dockerfile .")
                    // pushing image 
                    docker.withRegistry('https://registry.hub.docker.com',udayCred){
                        docker.image(imageName + ":" + imageTag).push()
                    }
                }
            }
            
        }

    }
}
