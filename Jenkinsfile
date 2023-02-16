pipeline {
    agent any

    stages {
        stage('Testing') {
            steps {
                withAWS(credentials:'clave-aws') {
		   sh 'terraform init && terraform validate'
                }
            }
        }

        stage('building') {
            steps {
                withAWS(credentials:'clave-aws') {
                   sshagent(['ssh-amazon']) {
			sh 'terraform apply -auto-approve'  
                    }
                }
            }
        }
    }
}
