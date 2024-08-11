#!/bin/bash
echo -e "\e[32m[*] Basic setup for services\e[0m"
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
WG_PASSWORD=$(read_input "Enter password for wg-easy" "admin")
TAIGA_DB_NAME=$(read_input "Enter Taiga database name" "admin")
TAIGA_DB_USER=$(read_input "Enter Taiga database user" "admin")
TAIGA_DB_PASSWORD=$(read_input "Enter Taiga database password" "admin")

# Creating .env file
mkdir -p docker
cat > docker/.env <<EOF
WG_PASSWORD=${WG_PASSWORD}
TAIGA_DB_NAME=${TAIGA_DB_NAME}
TAIGA_DB_USER=${TAIGA_DB_USER}
TAIGA_DB_PASSWORD=${TAIGA_DB_PASSWORD}
EOF

echo "File docker/.env was created with the following values:"
cat docker/.env

# Running docker containers
cd docker
echo -e "\e[32m[*] Starting Docker Compose\e[0m"
docker-compose up -d

echo -e "\e[32m[*] Docker containers setup and installation are completed\e[0m"
