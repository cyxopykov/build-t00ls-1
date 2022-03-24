#!/bin/bash
docker ps
docker build -f helloworld-project/helloworld-ws/Dockerfile -t 192.168.56.2:5000/helloworld-asukharukau:rc-$BUILD_NUMBER -t 192.168.56.2:5000/helloworld-asukharukau:latest .
docker login -u ${nexus_user} -p ${nexus_password} 192.168.56.2:5000
docker push 192.168.56.2:5000/helloworld-asukharukau:rc-$BUILD_NUMBER
docker push 192.168.56.2:5000/helloworld-asukharukau:latest
