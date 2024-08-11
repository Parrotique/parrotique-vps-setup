# Notes
## 📌 docker-intallation

In this script, the following steps occur:
1. Message Display: The script begins by displaying a message in green text indicating that the installation of Docker and Docker Compose is starting.
2. Docker Installation:
  - It downloads the official Docker installation script using `curl` and saves it as `get-docker.sh`.
  - The script is then executed with `sudo` to install Docker.
  - After the installation, Docker is started with `sudo systemctl start docker`.
  - Docker is enabled to start automatically on boot using `sudo systemctl enable docker`.
3. User Addition to Docker Group:
  - The script adds the current user to the docker group with `sudo usermod -aG docker $USER`, allowing the user to run Docker commands without needing `sudo`.
4. Docker Compose Installation:
  - The script installs Docker Compose using the package manager `apt`.
5. Completion Message:
  - Finally, the script displays another message in green text, indicating that the installation and setup of Docker and Docker Compose have been completed successfully.

## 📌 services-customization

This script guides the user through setting up basic services using Docker.
1. User Input:
  - The script prompts the user to confirm the installation of various services like `wg-easy`, `Nextcloud`, `Uptime Kuma`, `Rocket.Chat`, `MongoDB`, `Homer`, `Portainer`, and `Taiga`.
  - It also asks for specific credentials required for some services, such as `wg-easy` and `Taiga`.
2. Environment File Creation:
  - Based on user input, the script creates a `.env` file in the docker directory, storing the provided credentials.
3. Service Deployment:
  - Finally, the script runs Docker Compose to deploy the selected services.
  
## 📌 docker/docker-compose

This file sets up multiple services using Docker, each service running in its container. Below is a breakdown of the services included:
1. wg-easy
  - Image: ghcr.io/wg-easy/wg-easy
  - Purpose: Manages a WireGuard VPN server.
  - Variables:
    - `PASSWORD=${WG_PASSWORD}`: Sets the admin password for the web interface.
    - `WG_HOST=localhost`: Defines the hostname for the VPN.

2. Nextcloud
  - Image: nextcloud
  - Purpose: Provides a personal cloud storage service.
  - Variables:
    - `NEXTCLOUD_TRUSTED_DOMAINS=localhost`: Sets trusted domains for Nextcloud.

3. Uptime Kuma
  - Image: louislam/uptime-kuma:1
  - Purpose: Monitors the uptime of various services.
  - Variables:
    - `SERVER_IP=localhost`: Sets the server IP for monitoring.

4. Rocket.Chat
  - Image: rocketchat/rocket.chat:latest
  - Purpose: A communication platform similar to Slack.
  - Variables:
    - `MONGO_URL=mongodb://localhost:27017/rocketchat`
    - `ROOT_URL=http://localhost:3000`
    - `MONGO_OPLOG_URL=mongodb://localhost:27017/local`

5. MongoDB
  - Image: mongo:4.0
  - Purpose: A NoSQL database used by Rocket.Chat.
  - Volumes:
    - Maps `./rocketchat/mongo` on the host to `/data/db` inside the container.

6. Homer
  - Image: b4bz/homer
  - Purpose: A dashboard to organize links to services.
  - Volumes:
    - Maps `./homer/config.yml` on the host to `/www/config.yml` inside the container.

7. Portainer
  - Image: portainer/portainer-ce
  - Purpose: Provides a web interface to manage Docker containers.
  - Volumes:
    - Mounts Docker's socket `/var/run/docker.sock` and a data directory `portainer_data:/data`.

8. Taiga Backend
  - Image: ghcr.io/taigaio/taiga-back:latest
  - Purpose: Backend for the Taiga project management tool.
  - Variables:
    - `POSTGRES_HOST=localhost`
    - `POSTGRES_DB=${TAIGA_DB_NAME}`
    - `POSTGRES_USER=${TAIGA_DB_USER}`
    - `POSTGRES_PASSWORD=${TAIGA_DB_PASSWORD}`
  - Volumes:
    - Maps `./taiga-back` on the host to `/taiga-back` inside the container.
  - Dependencies:
    - Requires the Taiga database service (taiga-db) to start first.

9. Taiga Frontend
  - Image: ghcr.io/taigaio/taiga-front:latest
  - Purpose: Frontend for the Taiga project management tool.
  - Dependencies:
    - Requires the Taiga backend service (taiga-back) to start first.

11. Taiga Database (PostgreSQL)
  - Image: postgres:13
  - Purpose: Database service for Taiga.
  - Environment Variables:
    - `POSTGRES_DB=${TAIGA_DB_NAME}`
    - `POSTGRES_USER=${TAIGA_DB_USER}`
    - `POSTGRES_PASSWORD=${TAIGA_DB_PASSWORD}`
  - Volumes:
    - Maps `./taiga-db` on the host to `/var/lib/postgresql/data` inside the container.

## 📌 ufw-setup

This script sets up the UFW firewall on a Linux server to enhance security. Below is an overview of what the script does:
1. Installing UFW:
  - Installs the UFW package using the package manager (`apt`).
2. Allowing SSH Connections:
  - Configures UFW to allow `SSH` connections, ensuring that remote access to the server remains possible.
3. Enabling UFW:
  - Enables the UFW firewall with a force command, which automatically confirms the activation without manual input.
4. Allowing VPN Ports:
  - Opens the following ports to allow VPN connections:
    - `51820/udp`: The main WireGuard VPN port.
    - `51821/tcp`: An additional port for the WireGuard VPN interface.
5. Restricting Access to Specific Ports:
  - Configures UFW to allow access to several service ports only from the localhost (i.e., only when connected via VPN):
    - Port `1337`: Used for Nextcloud.
    - Port `3001`: Used for Uptime Kuma.
    - Port `3000`: Used for Rocket.Chat.
    - Port `8080`: Used for Homer.
    - Port `9000`: Used for Portainer.
    - Port `9100`: Used for the Taiga frontend.
6. Checking UFW Status:
    - Outputs the detailed status of UFW, showing which rules are active.

## 📌 fail2ban-setup

This script installs and configures Fail2Ban to protect your server from brute force attacks. Below is an overview of what the script does:
1. Installing Fail2Ban:
  - Uses `apt-get` to install the Fail2Ban package, which provides intrusion prevention and protection against brute force attacks.
2. Starting Fail2Ban Service:
  - Starts the Fail2Ban service to begin monitoring and protecting the server.
3. Completion Message:
  - Displays a message indicating that the Fail2Ban setup has been successfully completed.
