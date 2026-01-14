pipeline {
    agent any
    environment {
        PACKAGE_NAME = 'count-files'
        PACKAGE_VERSION = '1.0'
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
                sh 'ls -la'
            }
        }
        stage('Test Script') {
            steps {
                sh 'chmod +x count_files.sh'
                sh 'bash -n count_files.sh'
                sh './count_files.sh'
            }
        }
        stage('Build RPM') {
            agent {
                docker {
                    image 'fedora:latest'
                    args '-u root'
                }
            }
            steps {
                sh 'dnf install -y rpm-build rpmdevtools'
                sh 'rpmdev-setuptree'
                sh 'mkdir -p ~/rpmbuild/SOURCES/${PACKAGE_NAME}-${PACKAGE_VERSION}'
                sh 'cp count_files.sh ~/rpmbuild/SOURCES/${PACKAGE_NAME}-${PACKAGE_VERSION}/'
                sh 'tar czvf ~/rpmbuild/SOURCES/${PACKAGE_NAME}-${PACKAGE_VERSION}.tar.gz -C ~/rpmbuild/SOURCES ${PACKAGE_NAME}-${PACKAGE_VERSION}'
                sh 'cp packaging/rpm/count-files.spec ~/rpmbuild/SPECS/'
                sh 'rpmbuild -ba ~/rpmbuild/SPECS/count-files.spec'
            }
        }
        stage('Build DEB') {
            agent {
                docker {
                    image 'ubuntu:latest'
                    args '-u root'
                }
            }
            steps {
                sh 'apt-get update && apt-get install -y build-essential debhelper devscripts'
                sh 'mkdir -p build/${PACKAGE_NAME}-${PACKAGE_VERSION}'
                sh 'cp count_files.sh build/${PACKAGE_NAME}-${PACKAGE_VERSION}/'
                sh 'cp -r packaging/deb/debian build/${PACKAGE_NAME}-${PACKAGE_VERSION}/'
                sh 'cd build/${PACKAGE_NAME}-${PACKAGE_VERSION} && dpkg-buildpackage -us -uc -b'
            }
        }
    }
}
