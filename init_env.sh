#!/usr/bin/env bash

#sudo apt-get remove docker docker-engine docker.io containerd runc

#Check if Docker is installed
if [ ! -f "/usr/bin/docker" ]; then
#---------------
echo "update apt..."
sudo apt-get update
echo "[installing docker...]"
sudo apt-get install \
	    ca-certificates \
	        curl \
		    gnupg

echo "add docker GPG key..."
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
	  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
	    "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
	      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
echo "install docker Engine..."
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
echo "[docker install finished!!!]"
#-------------
else
	echo "[Docker is installed]"
fi

echo "[start install certbot]"
sudo snap install core; sudo snap refresh core
echo "[installing certbot...]"
if [ ! -f "/snap/bin/certbot" ]; then
	sudo snap install --classic certbot
else
	echo "certbot installed"
	if [ ! -f "/usr/bin/certbot" ]; then
		echo "linking certbot"
		sudo ln -s /snap/bin/certbot /usr/bin/certbot
	fi
fi
sudo certbot certonly --standalone
