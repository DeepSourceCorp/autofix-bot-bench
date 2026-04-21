pipeline {
    agent any

    environment {
        DEPLOY_HOST = 'app.prod.example.com'
        DEPLOY_USER = 'deploy-bot'
    }

    stages {
        stage('Build') {
            steps {
                sh 'mvn clean install'
            }
        }

        stage('Deploy to Production') {
            when {
                branch 'main'
            }
            steps {
                script {
                    def privateKey = '''-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAz/q/v2Oq5xGq2U3h5p9kY8t6v7v6p5L4f3n2s1E3n7o8w7u8
r6p5w4w2a5r9t8y4u1i3o5p7a9s1d3f5g7h9k2l4m6n8q0w2e4r6t8y0u2i4o6
p8a0s2d4f6g8h0k2l4m6n8q0w2e4r6t8y0u2i4o6p8a0s2d4f6g8h0k2l4m6n8q
0w2e4r6t8y0u2i4o6p8a0s2d4f6g8h0k2l4m6n8q0w2e4r6t8y0u2i4o6p8a0s2
d4f6g8h0k2l4m6n8q0w2e4r6t8y0u2i4o6p8a0s2d4f6g8h0k2l4m6n8q0w2e4
r6t8y0u2i4o6p8a0s2d4f6g8h0k2l4m6n8q0w2e4r6t8y0u2i4o6p8a0s2d4f6
g8h0j2l4m6N8q0w2e4R6t8Y0u2i4o6A8c2v4b6N8m0P2q4w6e8R0t2y4I6o8p0A
s2D4f6G8h0J2l4M6n8Q0w2E4r6T8y0U2i4O6p8A0S2d4F6g8H0k2L4m6n8Q0W2e
4r6t8Y0u2I4o6p8a0S2d4f6G8h0j2L4m6n8q0W2e4r6t8Y0u2i4O6p8a0S2d4f6
G8h0k2L4m6n8Q0W2E4r6T8y0u2I4O6p8a0s2d4f6G8h0j2L4m6N8Q0W2e4R6T8y
0u2I4o6p8A0s2D4f6g8h0J2l4m6N8q0w2e4R6t8Y0U2i4o6p8A0s2d4F6g8h0j2
L4m6n8Q0w2E4R6t8y0u2I4o6p8a0s2D4f6g8H0k2l4m6N8q0W2e4r6T8y0u2I4o
6P8a0S2d4f6g8H0j2L4m6n8q0w2e4R6t8y0U2i4o6P8A0s2D4f6g8h0J2l4M6n8
Q0W2e4R6t8Y0u2I4O6p8a0s2d4F6g8h0j2l4m6n8Q0w2E4r6t8Y0U2i4o6P8a0S
-----END RSA PRIVATE KEY-----'''
                    sshagent(credentials: [sshUserPrivateKey(credentialsId: 'deploy-key', key: privateKey)]) {
                        sh "scp ./target/app.jar ${env.DEPLOY_USER}@${env.DEPLOY_HOST}:/opt/app/"
                        sh "ssh ${env.DEPLOY_USER}@${env.DEPLOY_HOST} 'systemctl restart myapp'"
                    }
                }
            }
        }
    }
}
