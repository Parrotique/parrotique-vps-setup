#!/bin/bash

# Function for reading users responses
read_input() {
    local prompt="$1"
    local default="$2"
    local input

    read -r -p "$prompt [$default]: " input
    echo "${input:-$default}"
}

# Function for asking user desired containers
ask_container() {
    local container_name="$1"
    local default="$2"

    read -r -p "[*] Install $container_name? (y/n) [$default]: " choice
    echo "${choice:-$default}"
}

# Default parameters
DEFAULT="y"

# Asking about installation
install_wg_easy=$(ask_container "wg-easy" "$DEFAULT")
install_nextcloud=$(ask_container "Nextcloud" "$DEFAULT")
install_uptime_kuma=$(ask_container "Uptime Kuma" "$DEFAULT")
install_rocketchat=$(ask_container "Rocket.Chat" "$DEFAULT")
install_mongo=$(ask_container "MongoDB" "$DEFAULT")
install_homer=$(ask_container "Homer" "$DEFAULT")
install_portainer=$(ask_container "Portainer" "$DEFAULT")
install_taiga=$(ask_container "Taiga" "$DEFAULT")

# Asking for Hostname and additional parameters
IP_ADDRESS=$(read_input "Enter IP address" "localhost")
WG_PASSWORD=$(read_input "Enter password for wg-easy" "admin")
MONGO_HOST=$(read_input "Enter MongoDB host" "localhost")
MONGO_PORT=$(read_input "Enter MongoDB port" "27017")
TAIGA_DB_HOST=$(read_input "Enter Taiga database host" "localhost")
TAIGA_DB_NAME=$(read_input "Enter Taiga database name" "admin")
TAIGA_DB_USER=$(read_input "Enter Taiga database user" "admin")
TAIGA_DB_PASSWORD=$(read_input "Enter Taiga database password" "admin")

# Creating .env file
mkdir -p docker
cat > docker/.env <<EOF
WG_PASSWORD=${WG_PASSWORD}
WG_HOST_IP=${IP_ADDRESS}
NEXTCLOUD_HOST_IP=${IP_ADDRESS}
UPTIME_KUMA_HOST_IP=${IP_ADDRESS}
MONGO_HOST=${MONGO_HOST}
MONGO_PORT=${MONGO_PORT}
ROCKETCHAT_HOST_IP=${IP_ADDRESS}
TAIGA_DB_HOST=${TAIGA_DB_HOST}
TAIGA_DB_NAME=${TAIGA_DB_NAME}
TAIGA_DB_USER=${TAIGA_DB_USER}
TAIGA_DB_PASSWORD=${TAIGA_DB_PASSWORD}
EOF

echo "File docker/.env was created with the following values:"
cat docker/.env

# Running docker containers
cd docker
echo "Starting Docker Compose..."
docker-compose up -d

echo "Setup completed. Docker Compose has been started. You can start your work"
