echo -e "\e[32m[*] Docker and docker-compose installation and set up\e[0m"

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER
sudo apt install docker-compose

echo -e "\e[32m[*] Docker and docker-compose installation and set up was completed\e[0m"
