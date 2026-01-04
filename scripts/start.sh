#!/bin/bash
docker pull 434748505869.dkr.ecr.ap-south-1.amazonaws.com/simple-java-app:latest
docker run -d -p 9090:9090 --name simple-java-app \
  434748505869.dkr.ecr.ap-south-1.amazonaws.com/simple-java-app:latest
