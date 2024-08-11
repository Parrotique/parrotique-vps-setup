echo -e "\e[32m[*] Bruteforce protection setup\e[0m"

sudo apt-get install fail2ban -y
sudo systemctl start fail2ban

echo -e "\e[32m[*] Bruteforce protection setup was completed\e[0m"
