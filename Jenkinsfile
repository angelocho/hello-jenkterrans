pipeline {
    agent any

    stages {
        stage('Testing') {
            steps {
                withAWS(credentials:'clave-aws') {
		   sh 'terraform validate'
                }
            }
        }

        stage('building') {
            steps {
                withAWS(credentials:'clave-aws') {
                   sh 'terraform apply -auto-approve'
                }
            }
        }
    }
}
