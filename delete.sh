#!/bin/bash

docker ps -a

read -p "Which container would you like to delete?: " user_choice

docker stop $user_choice
docker rm $user_choice
