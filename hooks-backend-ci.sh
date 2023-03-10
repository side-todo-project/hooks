#!/bin/bash
# sync docker
docker stop todobackend && docker rm $_
docker rmi rollrat/todo-backend:latest
docker pull rollrat/todo-backend:latest

# download env-file for docker
aws s3api get-object --bucket todo-config --key .env.docker.prod .env.docker.prod

# setup docker
docker create --env-file ./.env.docker.prod \
                  --name todobackend \
                  --network host \
                  --add-host host.docker.internal:host-gateway \
                  rollrat/todo-backend:latest

# download env & copy to container
aws s3api get-object --bucket todo-config --key .prod.env .prod.env
docker cp .prod.env todobackend:/home/node/

# run docker
docker start todobackend
docker rmi $(docker images -q rollrat/todo-backend)

rm .env.docker.prod
rm .prod.env
