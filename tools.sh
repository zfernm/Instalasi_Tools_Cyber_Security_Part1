#!/bin/bash

RED="\e[31m"
GREEN="\e[1;32m"
BLUE="\e[1;34m"
MAGENTA="\e[35m"
RESET="\e[0m"
INFO="${GREEN}[ INFO ]"
PROSES="${BLUE}[ PROSES ]"

GOBIN="$(go env GOPATH)/bin"
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
        go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
        echo -e "${PROSES} Menginstall Httpx..."
        go install github.com/projectdiscovery/httpx/cmd/httpx@latest
        echo -e "${PROSES} Menginstall Nuclei..."
        go install github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest

        echo -e "${INFO} Memindahkan tools ke ${SEHARUSNYA}"
        for tool in subfinder httpx nuclei; do
            if [[ -f "$GOBIN/$tool" ]]; then
                mv "$GOBIN/$tool" "$SEHARUSNYA"
            else
                echo -e "${RED}Gagal menemukan $tool setelah instalasi.${RESET}"
            fi
        done
        echo -e "${INFO} Semua Tools Projectdiscovery berhasil terinstall."
        ;;

    2)
        echo -e "${PROSES} Menginstall dalfox..."
        go install github.com/hahwul/dalfox/v2@latest
        if [[ -f "$GOBIN/dalfox" ]]; then
            mv "$GOBIN/dalfox" "$SEHARUSNYA"
        fi
        echo -e "${INFO} dalfox berhasil terinstall."
        ;;

    3)
        echo -e "${PROSES} Menginstall sqlmap..."
        snap install sqlmap
        echo -e "${INFO} sqlmap berhasil terinstall."
        ;;

    4)
        echo -e "${PROSES} Menginstall ParamSpider..."
        if [[ -d /root/tools/ParamSpider ]]; then
            echo -e "${INFO} Folder ParamSpider sudah ada. Menghapus dan menginstall ulang..."
            rm -rf /root/tools/ParamSpider
        fi
        git clone https://github.com/devanshbatham/ParamSpider /root/tools/ParamSpider
        cd /root/tools/ParamSpider || { echo -e "${RED}Gagal masuk ke direktori.${RESET}"; exit 1; }
        if [[ -f requirements.txt ]]; then
            pip3 install -r requirements.txt
            echo -e "${INFO} ParamSpider berhasil terinstall."
        else
            echo -e "${RED}File requirements.txt tidak ditemukan! Menginstall dependensi secara manual...${RESET}"
            pip3 install certifi==2020.4.5.1 chardet==3.0.4 idna==2.9 requests==2.23.0 urllib3==1.25.8
        fi
        ;;



    5)
        echo -e "${PROSES} Menginstall FFUF..."
        go install github.com/ffuf/ffuf@latest
        if [[ -f "$GOBIN/ffuf" ]]; then
            mv "$GOBIN/ffuf" "$SEHARUSNYA"
        fi
        echo -e "${INFO} FFUF berhasil terinstall."
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
        go install github.com/tomnomnom/waybackurls@latest
        if [[ -f "$GOBIN/waybackurls" ]]; then
            mv "$GOBIN/waybackurls" "$SEHARUSNYA"
        fi
        echo -e "${INFO} Waybackurls berhasil terinstall."
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
