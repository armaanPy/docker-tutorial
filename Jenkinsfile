def dockerImage;
    
node('docker') {
    stage('Checkout SCM') {
        checkout([$class: 'GitSCM', branches: [[name: '*/master']],
        userRemoteConfigs: [[url: 'https://github.com/armaanPy/docker-tutorial']]])
    }
    
    stage('Build') {
        dockerImage = docker.build('armaanpy/gsd:v$BUILD_NUMBER -f gsd.Dockerfile .')
    }

    stage('Push') {
        docker.withRegistry('', 'dockerhubcreds') {
            dockerImage.push()
        }
    }
}

