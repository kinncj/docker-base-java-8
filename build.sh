#!/bin/bash
IMAGE_TAG="kinncj/base-java-8"
docker build -t $IMAGE_TAG .
docker push $IMAGE_TAG
