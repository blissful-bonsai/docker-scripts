#!/bin/bash
# Awk could put them side by side to list container name and ip
echo "Available containers"
docker ps
read -p "Enter the name of the container you want to inspect: " user_choice
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $user_choice

