#!/bin/bash
# Run a while loop to check whether or not the container already exists.
# Do the same when creating a option for the network
read -p "Please insert your mysql-container name: " container_name;
read -p "Please insert your root password: " root_password;
read -p "Please insert the name of the database: " database_name;
read -p "Please insert a username for you to log with: " username;
read -p "What's the password for this user? : " user_password

docker run -d \
  --name $container_name \
  -e MYSQL_ROOT_PASSWORD=$root_password \
  -e MYSQL_DATABASE=$database_name \
  -e MYSQL_USER=$username \
  -e MYSQL_PASSWORD=$user_password \
  -v $(pwd)/mysql-data:/var/lib/mysql \
  -p 3306:3306 \
  mysql:latest

