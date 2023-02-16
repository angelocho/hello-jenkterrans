pipeline {
    agent any

    stages {
        stage('Testing') {
            steps {
                   sh 'docker-compose config'
                withAWS(credentials:'clave-aws') {
		   sh 'terraform init && terraform validate'
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
                   sshagent(['ssh-amazon']) {
			sh 'terraform apply -auto-approve'
                        dir('./ansible') {
                           sh 'ansible-playbook -i aws_ec2.yaml httpd_2048.yml'
                           sshagent(['clave-sinensia']) {
                               sh 'ansible-playbook -i aws_ec2.yaml dockercompup.yaml'
                           }
			 }  
                    }   
                }
            }
        }

    }
}
