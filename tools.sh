#!/bin/bash

RED="\e[31m"
GREEN="\e[1;32m"
BLUE="\e[1;34m"
MAGENTA="\e[35m"
RESET="\e[0m"

INFO="${GREEN}[ INFO ]${RESET}"
PROSES="${BLUE}[ PROSES ]${RESET}"
ERR="${RED}[ ERROR ]${RESET}"

export PATH=/usr/local/go/bin:$PATH
export GOPATH="${GOPATH:-$HOME/go}"
export GOBIN="${GOBIN:-$GOPATH/bin}"
export PATH="$PATH:$GOBIN"

INSTALL_BIN="/usr/local/bin"

logo(){
clear
echo -e "${RED}"
echo "#########################################################"
echo "#           TOOLS CYBER SECURITY INSTALLER              #"
echo "#########################################################"
echo "███████ ███████ ███████ ██████  ███    ██ ███    ███"
echo "    ███ ██      ██      ██   ██ ████   ██ ████  ████"
echo "  ███   █████   █████   ██████  ██ ██  ██ ██ ████ ██"
echo "███     ██      ██      ██   ██ ██  ██ ██ ██  ██  ██"
echo "███████ ██      ███████ ██   ██ ██   ████ ██      ██"
echo -e "${RESET}"
echo -e "${GREEN}Tools created by ZFERNM x META4SEC${RESET}"
echo ""
}

if [[ $EUID -ne 0 ]]; then
echo -e "${ERR} Jalankan sebagai root"
exit
fi

install_dependencies(){

echo -e "${PROSES} Install dependencies..."

apt update -y
apt install -y git curl wget unzip python3 python3-pip ca-certificates snapd

}

version_ge(){
[[ "$(printf '%s\n' "$2" "$1" | sort -V | head -n1)" == "$2" ]]
}

install_go(){

REQUIRED="1.20.0"

if command -v go >/dev/null 2>&1; then
GOV=$(go version | awk '{print $3}' | sed 's/go//')
else
GOV="0"
fi

if version_ge "$GOV" "$REQUIRED"; then
echo -e "${INFO} Go version $GOV OK"
return
fi

echo -e "${PROSES} Installing latest Go..."

cd /tmp || exit

wget https://go.dev/dl/go1.24.1.linux-amd64.tar.gz

rm -rf /usr/local/go
tar -C /usr/local -xzf go1.24.1.linux-amd64.tar.gz

export PATH=$PATH:/usr/local/go/bin

echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc

source ~/.bashrc

echo -e "${INFO} Installed Go:"
go version

}

go_install(){

MODULE=$1
BIN=$2

echo -e "${PROSES} Installing $BIN..."

go install $MODULE

if [[ -f "$GOBIN/$BIN" ]]; then

mv "$GOBIN/$BIN" $INSTALL_BIN

echo -e "${INFO} $BIN installed"

else

echo -e "${ERR} Failed install $BIN"

fi

}

install_subfinder(){
install_go
go_install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest subfinder
}

install_httpx(){
install_go
go_install github.com/projectdiscovery/httpx/cmd/httpx@latest httpx
}

install_nuclei(){
install_go
go_install github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest nuclei
}

install_dalfox(){
install_go
go_install github.com/hahwul/dalfox/v2@latest dalfox
}

install_ffuf(){
install_go
go_install github.com/ffuf/ffuf@latest ffuf
}

install_wayback(){
install_go
go_install github.com/tomnomnom/waybackurls@latest waybackurls
}

install_sqlmap(){

echo -e "${PROSES} Installing sqlmap..."

git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git /opt/sqlmap

ln -sf /opt/sqlmap/sqlmap.py /usr/local/bin/sqlmap

echo -e "${INFO} sqlmap installed"

}

install_paramspider(){

echo -e "${PROSES} Installing ParamSpider..."

mkdir -p /opt/tools

git clone https://github.com/devanshbatham/ParamSpider /opt/tools/ParamSpider

pip3 install -r /opt/tools/ParamSpider/requirements.txt

echo -e "${INFO} ParamSpider installed"

}

install_dirsearch(){

echo -e "${PROSES} Installing dirsearch..."

mkdir -p /opt/tools

git clone https://github.com/maurosoria/dirsearch.git /opt/tools/dirsearch

echo -e "${INFO} dirsearch installed"

}

install_nmap(){

echo -e "${PROSES} Installing nmap..."

apt install -y nmap

echo -e "${INFO} nmap installed"

}

menu(){

logo

echo "1) Install Subfinder"
echo "2) Install HTTPX"
echo "3) Install Nuclei"
echo "4) Install Dalfox"
echo "5) Install sqlmap"
echo "6) Install ParamSpider"
echo "7) Install FFUF"
echo "8) Install Dirsearch"
echo "9) Install NMAP"
echo "10) Install Waybackurls"
echo "0) Exit"

echo ""
read -p "Choose: " opt

case $opt in

1) install_subfinder ;;
2) install_httpx ;;
3) install_nuclei ;;
4) install_dalfox ;;
5) install_sqlmap ;;
6) install_paramspider ;;
7) install_ffuf ;;
8) install_dirsearch ;;
9) install_nmap ;;
10) install_wayback ;;
0) exit ;;

*) echo "Invalid option"

esac

}

install_dependencies

while true
do
menu
done
