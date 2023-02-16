pipeline {
    agent any
    options{
        timestamps()
        ansiColor('xterm')
    }
    stages {
        stage('Testing') {
            steps {
                   sh 'docker-compose config'
                withAWS(credentials:'clave-aws',region: 'eu-west-1') {
                      dir('./terraform') {
                          sh 'terraform init && terraform validate'
                     }

                }
            }
        }
        stage('BuildDocker') {
            steps {
                sh 'docker-compose build'
                sh 'git tag 1.0.${BUILD_NUMBER}'
                sshagent(['clave-sinensia']) {
                        sh 'git push --tags'
                }
                sh "docker tag ghcr.io/angelocho/hello-jenkterrans:latest ghcr.io/angelocho/hello-jenkterrans:1.0.${BUILD_NUMBER}"
            }
        }
        stage('Dockerlogin'){
           steps {
             withCredentials([string(credentialsId: 'github-token', variable: 'PAT')]) {
                 sh 'echo $PAT | docker login ghcr.io -u angelocho --password-stdin && docker-compose push && docker push ghcr.io/angelocho/hello-jenkterrans:1.0.${BUILD_NUMBER}'

             }

           }
        }

        stage('Buildingterraform') {
            steps {
                withAWS(credentials:'clave-aws') {
                    dir('./terraform') {
			sh 'terraform apply -auto-approve'
                    }   
                }
            }
        }
        stage('Configuringwithansible') {
            steps {
                withAWS(credentials:'clave-aws') {
                   dir('./ansible') {
                           ansiblePlaybook colorized: true, credentialsId: 'ssh-amazon', inventory: 'aws_ec2.yaml', playbook: 'httpd_2048.yml'
                           ansiblePlaybook colorized: true, credentialsId: 'ssh-amazon', inventory: 'aws_ec2.yaml', playbook: 'dockercompup.yaml'
                   } 
                }
            }
        }
    }
}
