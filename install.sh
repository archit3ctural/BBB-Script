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
wget https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && chmod 755 msfinstall && ./msfinstall

# Install and move Go to $PATH environment, then upgrade packages
wget https://dl.google.com/go/go1.13.5.linux-amd64.tar.gz
sudo tar -C /usr/local/ -xzf go1.13.5.linux-amd64.tar.gz
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
echo 'export GOROOT=/usr/local/go' >> ~/.bash_profile
echo 'export GOPATH=$HOME/go'	>> ~/.bash_profile			
echo 'export PATH=$GOPATH/bin:$GOROOT/bin:$PATH\n' >> ~/.bash_profile	
source ~/.bash_profile
go get -u ./...

# Install nuclei
go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest

# Install aquatone then move to the /bin directory
git clone https://github.com/michenriksen/aquatone.git
unzip aquatone* aquatone
sudo chmod +x aquatone 
sudo mv aquatone /usr/bin

# Install dnmasscan using git clone then move to the /bin directory
git clone https://github.com/rastating/dnmasscan.git
cd dnmasscan/
sudo chmod +x dnmasscan 
sudo mv dnmasscan /usr/bin/

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

# Add crt.sh shortcut to /bin to allow it use within bash scripts
echo "curl -s https://crt.sh/?Identity=%.$1 \| grep ">*.$1" \| sed 's/<[/]*[TB][DR]>/\n/g' \| grep -vE "<|^[\*]*[\.]*$1" \| sort -u \| awk 'NF'" > /bin/crtsh
sudo chmod +x /bin/crtsh




