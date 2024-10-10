read -p "Insert the container name:" container_name
read -p "Insert the hostname for the container:" hostname
read -p "Insert the sa password:" password

docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=$password" \
   -p 1433:1433 --name $container_name --hostname $hostname \
   -d \
   mcr.microsoft.com/mssql/server:2022-latest

docker exec -it $container_name "bash"






