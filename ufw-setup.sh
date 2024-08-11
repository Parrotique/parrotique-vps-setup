echo -e "\e[32m[*] UFW setup\e[0m"

#installing ufw
sudo apt install -y ufw

#allowing ssh and turn on the protection
sudo ufw allow ssh
sudo ufw --force enable

#allowing ports for VPN
sudo ufw allow 51820/udp
sudo ufw allow 51821/tcp

#access only with vpn for the following ports
sudo ufw allow from localhost to any port 1337
sudo ufw allow from localhost to any port 3001
sudo ufw allow from localhost to any port 3000
sudo ufw allow from localhost to any port 8080
sudo ufw allow from localhost to any port 9000
sudo ufw allow from localhost to any port 9100

#status check
sudo ufw status verbose

echo -e "\e[32m[*] UFW setup was completed\e[0m"
