#!/usr/bin/env bash
# deploy.sh
set -e # stop if something goes wrong

docker build -f php/Dockerfile   -t ghcr.io/inkku3/primergy-lab-php:latest   .
docker build -f nginx/Dockerfile -t ghcr.io/inkku3/primergy-lab-nginx:latest .

docker push ghcr.io/inkku3/primergy-lab-php:latest
docker push ghcr.io/inkku3/primergy-lab-nginx:latest

# kubectl rollout restart deployment/php-deployment -n apps
# kubectl rollout restart deployment/nginx-deployment -n apps
