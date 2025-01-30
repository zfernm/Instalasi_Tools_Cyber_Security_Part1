#!/bin/bash

RED="\e[31m"
GREEN="\e[1;32m"
BLUE="\e[1;34m"
MAGENTA="\e[35m"
RESET="\e[0m"
INFO="${GREEN}[ INFO ]"
PROSES="${BLUE}[ PROSES ]"

SUBFINDER="go/bin/subfinder"
HTTPX="go/bin/httpx"
NUCLEI="go/bin/nuclei"
DALFOX="go/bin/dalfox"
FFUF="go/bin/ffuf"
WAYBACKURLS="go/bin/waybackurls"
SEHARUSNYA="/usr/local/bin"

TELEGRAM="https://t.me/zfernm"
LINKEDIN="https://www.linkedin.com/in/samuel-hamonangan-s-099604255/"
INSTAGRAM="https://www.instagram.com/samuellhsss"

logo() {
    echo -e "${RED}"
    echo " ######################################################### "
    echo " #              TOOLS CYBER SECURITY PART 1              # "
    echo " ######################################################### "
    echo " ███████ ███████ ███████ ██████  ███    ██ ███    ███ "
    echo "     ███ ██      ██      ██   ██ ████   ██ ████  ████ "
    echo "   ███   █████   █████   ██████  ██ ██  ██ ██ ████ ██ "
    echo " ███     ██      ██      ██   ██ ██  ██ ██ ██  ██  ██ "
    echo " ███████ ██      ███████ ██   ██ ██   ████ ██      ██ "
    echo -e "${RESET}"
    echo -e "${GREEN} Tools created by ZFERNM X META4SEC ${RESET}"
    echo ""
}

if [[ $EUID -ne 0 ]]; then
    echo -e "${RED}Anda harus menjalankan script sebagai root untuk melanjutkan.${RESET}"
    exit 1
fi

OS=$(lsb_release -is)
if [[ $OS != "Debian" && $OS != "Ubuntu" && $OS != "Kali" ]]; then
    echo -e "${RED}Script hanya dapat dijalankan pada Debian, Ubuntu, atau Kali Linux.${RESET}"
    exit 1
fi

sudo apt update && sudo apt upgrade -y
sudo apt install -y snap snapd python3-pip
clear

logo

echo -e "${PROSES} Pilih Opsi:
[1] Install projectdiscovery
[2] Install dalfox
[3] Install sqlmap
[4] Install ParamSpider
[5] Install FFUF
[6] Install Dirsearch
[7] Install NMAP
[8] Install Waybackurls
[9] Beli VPS & RDP
[x] Exit
Pilihan: [1-9 or x]"
read -r pilihan

case $pilihan in
    1)
        echo -e "${PROSES} Menginstall Subfinder..."
        go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
        echo -e "${INFO} Subfinder berhasil dipasang"

        echo -e "${PROSES} Menginstall Httpx..."
        go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
        echo -e "${INFO} Httpx berhasil dipasang"

        echo -e "${PROSES} Menginstall Nuclei..."
        go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
        echo -e "${INFO} Nuclei berhasil dipasang"

        echo -e "${INFO} Memindahkan tools ke ${SEHARUSNYA}"
        mv ${SUBFINDER} ${SEHARUSNYA}
        mv ${HTTPX} ${SEHARUSNYA}
        mv ${NUCLEI} ${SEHARUSNYA}
        echo -e "${INFO} Semua Tools Projectdiscovery berhasil terinstall."
        ;;

    2)
        echo -e "${PROSES} Menginstall dalfox..."
        go install github.com/hahwul/dalfox/v2@latest
        mv ${DALFOX} ${SEHARUSNYA}
        echo -e "${INFO} dalfox berhasil terinstall dan dipindahkan ke ${SEHARUSNYA}."
        ;;

    3)
        echo -e "${PROSES} Menginstall sqlmap..."
        snap install sqlmap
        echo -e "${INFO} sqlmap berhasil terinstall."
        ;;

    4)
        echo -e "${PROSES} Menginstall ParamSpider..."
        git clone https://github.com/devanshbatham/ParamSpider ~/tools/ParamSpider
        cd ~/tools/ParamSpider || exit
        sudo pip3 install -r requirements.txt
        echo -e "${INFO} ParamSpider berhasil terinstall."
        ;;

    5)
        echo -e "${PROSES} Menginstall FFUF..."
        go get -u github.com/ffuf/ffuf
        mv ${FFUF} ${SEHARUSNYA}
        echo -e "${INFO} FFUF berhasil terinstall dan dipindahkan ke ${SEHARUSNYA}."
        ;;

    6)
        echo -e "${PROSES} Menginstall Dirsearch..."
        git clone https://github.com/maurosoria/dirsearch.git ~/tools/dirsearch
        echo -e "${INFO} Dirsearch berhasil terinstall."
        ;;

    7)
        echo -e "${PROSES} Menginstall NMAP..."
        sudo apt install -y nmap
        echo -e "${INFO} NMAP berhasil terinstall."
        ;;

    8)
        echo -e "${PROSES} Menginstall Waybackurls..."
        go get -u github.com/tomnomnom/waybackurls
        mv ${WAYBACKURLS} ${SEHARUSNYA}
        echo -e "${INFO} Waybackurls berhasil terinstall dan dipindahkan ke ${SEHARUSNYA}."
        ;;

    9)
        echo -e "${MAGENTA} Telegram: ${TELEGRAM}${RESET}"
        echo -e "${MAGENTA} LinkedIn: ${LINKEDIN}${RESET}"
        echo -e "${MAGENTA} Instagram: ${INSTAGRAM}${RESET}"
        ;;

    x|X)
        exit
        ;;

    *)
        echo -e "${RED} Pilihan tidak valid. Silakan pilih opsi yang tersedia.${RESET}"
        ;;
esac
