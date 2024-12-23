#!/bin/bash


docker pull httpd:latest


docker run -d --name myweb1 -p 8080:80 httpd:latest


echo "Running containers:"
docker ps 

echo "Container logs:"
docker logs myweb1


echo "Container details:"
docker inspect myweb1

echo "Docker images:"
docker images


echo "Docker system information:"
docker info


echo "Container stats:"
docker stats --no-stream myweb1
