#!/bin/bash

# Port input validation
validate_port(){
	port=$1

	if [[ $port -ge 1024 && $port -le 65535 ]]; then # -eg Greater Than/Equal to       # -le Less Than/Equal to
		return 0 # Valid
	else
		return 1 # Not valid
	fi
}

# Validates if the input by the user is numerical or not 
is_numerical(){
	user_input=$1

	if [[ $user_input =~ ^[0-9]+$ ]]; then
		return 0
	else
		return 1
	fi
}

# Validates whether or not the user typed something before pressing enter when asked for input
is_filled(){
	user_input=$1
	if [[ -n "$user_input" ]]; then
		return 0
	else
		echo "You need to input something in this line"
		return 1
	fi	
}

# Service specification
create_service(){
	while true; do
    	read -p "Service name: " service_name
		if is_filled "$service_name"; then
			break
		fi
    done
	echo "  $service_name:" >> docker-compose.yml

	read -p "(Optional) Container name: " container_name
	echo "    container_name: $container_name" >> docker-compose.yml

	echo "These are the images in your computer that you can use for this container: "
	docker images
	while true; do
		read -p "Please specify an image for this container: " image_name
		if is_filled "$image_name"; then
			break
		fi
	done
	echo "    image: $image_name" >> docker-compose.yml

    echo "You can choose ports in the range 1024 to 65535 for both host and container ports."
	while true; do
		read -p "Host port to be opened: " host_port
		if validate_port "$host_port"; then # Bash automatically converts strings to numbers if needed for comparison
			break
		else
			echo "Invalid port, please choose between 1024 and 65535"
		fi
    done
	while true; do
		read -p "Container port to be opened: " container_port
		if validate_port "$container_port"; then 
			break
		else
			echo "Invalid port, please choose between 1024 and 65535"
		fi
	done
	ports="${host_port}:${container_port}" # When assigning a value to a variable in bash we don't use $
	echo "    ports:" >> docker-compose.yml
	echo "      - $ports" >> docker-compose.yml

	while true; do

	done

	while true; do
		read -n 1 -p "Do you wish to create a volume and attach the container to it? (y/n): " volume_choice # Add the validation here aswell
		if [[ "$volume_choice" == [yY] ]]; then
			echo 
			read -p "Enter the volume name: " volume_name
			echo "    volumes:" >> docker-compose.yml
			break
		elif [[ "$volume_choice" == [nN] ]]; then
			echo "No volume will be created."
			break
		else
			echo "Enter either Y/y or N/n"
		fi
	done 
	
	echo -e "\n\nService $service_name successfully added to the composer file"
}

echo -e "Welcome to the docker-compose file creation!\nThis version allows you to create services like a web app, a microservice or a database"
touch docker-compose.yml
echo "version: '3'" >> docker-compose.yml
echo >> docker-compose.yml
echo "services: " >> docker-compose.yml

# Loop to create the number of services specified by the user
service_creation(){
	while true; do
		read -p "Please insert the number of services you want to create: " number_of_services
		if is_numerical "$number_of_services"; then
			break
		else
			echo "Please insert a number"
		fi
    done
	for ((i = 1; i<= number_of_services; i++)) do
      create_service
    done
}
service_creation
