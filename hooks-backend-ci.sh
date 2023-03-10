#!/bin/bash
# sync docker
docker stop todobackend && docker rm $_
docker rmi rollrat/todo-backend:latest
docker pull rollrat/todo-backend:latest

# setup docker
docker create --name todobackend \
              --network host \
              rollrat/todo-backend:latest

# download env & copy to container
aws s3api get-object --bucket todo-config --key .env.docker.prod .env
docker cp .prod.env todobackend:/home/node/

# run docker
docker start todobackend
docker rmi $(docker images -q rollrat/todo-backend)

rm .env.docker.prod
