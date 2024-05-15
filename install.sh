#!/bin/bash

# Run apt-get update & upgrade
sudo apt-get -y update
sudo apt-get -y upgrade

# Create home directories
mkdir $HOME/{Downloads,Tools,Scripts}

# Store packages to be installed into packages.txt
cd Downloads

echo "apt-transport-https \
ca-certificates \
cewl \
chromium-browser \
curl \
default-jdk \
default-jdk \
docker \
docker-compose \
git \
gnupg \
gnupg \
gobuster \
hashcat \
htop \
hydra \
john \
libcap2-bin \
lsb-release \
masscan \
mlocate \
nbtscan \
net-tools \
net-tools \
nfs-common \
nfs-kernel-server \
nikto \
nmap \
openvpn \
p7zip-full \
p7zip-rar \
python3-impacket \
python3-pip \
remmina \
ruby-full \
ruby-railties \
software-properties-common \
squid \
unzip \
tmux \
traceroute \
tree \
vim \
vlc \
wfuzz \
whois \
wireguard \
wireguard-tools \
zsh
" > packages.txt

# Install packages in packages.txt
cat packages.txt | xargs sudo apt-get install -y

# Install amass using snap
sudo snap install amass   

# Install metasploit
sudo snap install metasploit-framework

# Install and move Go to $PATH environment, then upgrade packages
sudo snap install go --classic
go get -u ./...

# Install nuclei
git clone https://github.com/projectdiscovery/nuclei.git
cd nuclei/v2/cmd/nuclei/
sudo go build .
sudo mv nuclei /usr/local/bin/

# Install dnmasscan using git clone then move to the /bin directory
git clone https://github.com/rastating/dnmasscan.git
cd dnmasscan/
sudo chmod +x dnmasscan 
sudo mv dnmasscan /usr/bin/

# Install aquatone then move to the /bin directory
curl -s https://api.github.com/repos/michenriksen/aquatone/releases/latest | grep "browser_download_url.*linux_amd64-*" | cut -d : -f 2,3 | tr -d \" | wget -i -
unzip aquatone* aquatone
chmod +x aquatone 
sudo mv aquatone /usr/bin/

# Install ffuf then move to the /bin directory
curl -s https://api.github.com/repos/ffuf/ffuf/releases/latest | grep "browser_download_url.*linux_amd64.tar.gz" | cut -d : -f 2,3 | tr -d \" | wget -i -
tar xzf ffuf* ffuf
chmod +x ffuf
sudo mv ffuf /usr/bin/

# Install httpx then move to the /bin directory
curl -s https://api.github.com/repos/projectdiscovery/httpx/releases/latest | grep "browser_download_url.*linux_amd64.zip" | cut -d : -f 2,3 | tr -d \" | wget -i -
unzip httpx* httpx
chmod +x httpx
sudo mv httpx /usr/bin/

# Install subfinder then move to the /bin directory
curl -s https://api.github.com/repos/projectdiscovery/subfinder/releases/latest | grep "browser_download_url.*linux_amd64.zip" | cut -d : -f 2,3 | tr -d \" | wget -i -
unzip subfinder* subfinder
chmod +x subfinder
sudo mv subfinder /usr/bin/

# Add nahamsec aliases to bash_profile
git clone https://github.com/nahamsec/recon_profile.git
cd recon_profile
cat .bash_profile >> ~/.bash_profile
sleep 1
source ~/.bash_profile
cd ..
sudo rm -r recon_profile

# Clone SecLists repo
cd ~
git clone https://github.com/danielmiessler/SecLists/

# Clean up home directory
cd ~/
sudo rm -r BBB-Script/
sudo rm -r go/
sudo rm -r nuclei/
sudo rm -r snap/







