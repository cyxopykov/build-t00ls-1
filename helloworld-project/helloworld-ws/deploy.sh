#!/bin/bash
prev=$(docker ps --format='{{.Image}}' -f name=helloworld-asukharukau-rc)
docker ps -af name=helloworld-asukharukau-rc -q | xargs -r docker container rm -f
port=$((8080+${BUILD}))
docker run -d -p ${port}:8080 --name helloworld-asukharukau-rc-${BUILD} 192.168.56.2:5000/helloworld-asukharukau:rc-${BUILD}
sleep 10

if [[ $(curl -sSf http://192.168.56.2:${port}/helloworld-ws/ > /dev/null) ]]
then
  docker ps -af name=helloworld-asukharukau-rc -q | xargs -r docker container rm -f
  #rollback 
  docker run -d -p ${port}:8080 --name helloworld-asukharukau-rc-${BUILD} $prev
fi
echo $prev
