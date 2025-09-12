#!/bin/bash

RED="\e[31m"
GREEN="\e[1;32m"
BLUE="\e[1;34m"
MAGENTA="\e[35m"
RESET="\e[0m"
INFO="${GREEN}[ INFO ]"
PROSES="${BLUE}[ PROSES ]"

# lebih toleran jika GOPATH kosong -> default ke $HOME/go
GOPATH="$(go env GOPATH 2>/dev/null || echo "$HOME/go")"
GOBIN="${GOPATH}/bin"
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

OS=$(lsb_release -is 2>/dev/null || echo "Unknown")
if [[ $OS != "Debian" && $OS != "Ubuntu" && $OS != "Kali" && $OS != "LinuxMint" ]]; then
    echo -e "${RED}Script hanya dapat dijalankan pada Debian, Ubuntu, atau Kali Linux.${RESET}"
    exit 1
fi

# Update sistem dan install dasar
apt update && apt upgrade -y
apt install -y snap snapd python3-pip golang-go git

clear
logo

echo -e "${PROSES} Pilih Opsi:
[1] Install Subfinder (projectdiscovery/subfinder)
[2] Install HTTPX (projectdiscovery/httpx)
[3] Install Nuclei (projectdiscovery/nuclei)
[4] Install dalfox
[5] Install sqlmap
[6] Install ParamSpider
[7] Install FFUF
[8] Install Dirsearch
[9] Install NMAP
[10] Install Waybackurls
[11] Beli VPS & RDP (kontak)
[x] Exit
Pilihan: [1-11 or x]"
read -r pilihan

case $pilihan in
    1)
        echo -e "${PROSES} Menginstall Subfinder..."
        # pastikan go tersedia
        if ! command -v go >/dev/null 2>&1; then
            echo -e "${RED}Go tidak ditemukan. Pastikan golang-go terinstall.${RESET}"
            exit 1
        fi
        /usr/bin/env bash -lc "go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest"
        if [[ -f "$GOBIN/subfinder" ]]; then
            mv "$GOBIN/subfinder" "$SEHARUSNYA"
            echo -e "${INFO} subfinder sudah dipindahkan ke ${SEHARUSNYA}"
        else
            echo -e "${RED}Gagal menemukan subfinder di ${GOBIN}, coba cek PATH go bin kamu.${RESET}"
        fi
        ;;

    2)
        echo -e "${PROSES} Menginstall HTTPX..."
        /usr/bin/env bash -lc "go install github.com/projectdiscovery/httpx/cmd/httpx@latest"
        if [[ -f "$GOBIN/httpx" ]]; then
            mv "$GOBIN/httpx" "$SEHARUSNYA"
            echo -e "${INFO} httpx sudah dipindahkan ke ${SEHARUSNYA}"
        else
            echo -e "${RED}Gagal menemukan httpx di ${GOBIN}.${RESET}"
        fi
        ;;

    3)
        echo -e "${PROSES} Menginstall Nuclei..."
        /usr/bin/env bash -lc "go install github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest"
        if [[ -f "$GOBIN/nuclei" ]]; then
            mv "$GOBIN/nuclei" "$SEHARUSNYA"
            echo -e "${INFO} nuclei sudah dipindahkan ke ${SEHARUSNYA}"
        else
            echo -e "${RED}Gagal menemukan nuclei di ${GOBIN}.${RESET}"
        fi
        ;;

    4)
        echo -e "${PROSES} Menginstall dalfox..."
        /usr/bin/env bash -lc "go install github.com/hahwul/dalfox/v2@latest"
        if [[ -f "$GOBIN/dalfox" ]]; then
            mv "$GOBIN/dalfox" "$SEHARUSNYA"
            echo -e "${INFO} dalfox berhasil terinstall."
        else
            echo -e "${RED}Gagal menemukan dalfox di ${GOBIN}.${RESET}"
        fi
        ;;

    5)
        echo -e "${PROSES} Menginstall sqlmap..."
        # snap kadang membutuhkan restart snapd; pakai snap jika tersedia
        if command -v snap >/dev/null 2>&1; then
            snap install sqlmap
            echo -e "${INFO} sqlmap berhasil terinstall via snap."
        else
            echo -e "${PROSES} snap tidak ditemukan, menginstall sqlmap via git..."
            git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git /opt/sqlmap
            ln -sf /opt/sqlmap/sqlmap.py /usr/local/bin/sqlmap
            echo -e "${INFO} sqlmap berhasil di-clone ke /opt/sqlmap dan symlink dibuat."
        fi
        ;;

    6)
        echo -e "${PROSES} Menginstall ParamSpider..."
        if [[ -d /root/tools/ParamSpider ]]; then
            echo -e "${INFO} Folder ParamSpider sudah ada. Menghapus dan menginstall ulang..."
            rm -rf /root/tools/ParamSpider
        fi
        git clone https://github.com/devanshbatham/ParamSpider /root/tools/ParamSpider
        cd /root/tools/ParamSpider || { echo -e "${RED}Gagal masuk ke direktori ParamSpider.${RESET}"; exit 1; }
        if [[ -f requirements.txt ]]; then
            pip3 install -r requirements.txt
            echo -e "${INFO} ParamSpider berhasil terinstall."
        else
            echo -e "${RED}File requirements.txt tidak ditemukan! Menginstall dependensi secara manual...${RESET}"
            pip3 install certifi==2020.4.5.1 chardet==3.0.4 idna==2.9 requests==2.23.0 urllib3==1.25.8
        fi
        ;;

    7)
        echo -e "${PROSES} Menginstall FFUF..."
        /usr/bin/env bash -lc "go install github.com/ffuf/ffuf@latest"
        if [[ -f "$GOBIN/ffuf" ]]; then
            mv "$GOBIN/ffuf" "$SEHARUSNYA"
            echo -e "${INFO} FFUF berhasil terinstall."
        else
            echo -e "${RED}Gagal menemukan ffuf di ${GOBIN}.${RESET}"
        fi
        ;;

    8)
        echo -e "${PROSES} Menginstall Dirsearch..."
        mkdir -p ~/tools
        git clone https://github.com/maurosoria/dirsearch.git ~/tools/dirsearch
        echo -e "${INFO} Dirsearch berhasil di-clone ke ~/tools/dirsearch."
        ;;

    9)
        echo -e "${PROSES} Menginstall NMAP..."
        apt install -y nmap
        echo -e "${INFO} NMAP berhasil terinstall."
        ;;

    10)
        echo -e "${PROSES} Menginstall Waybackurls..."
        /usr/bin/env bash -lc "go install github.com/tomnomnom/waybackurls@latest"
        if [[ -f "$GOBIN/waybackurls" ]]; then
            mv "$GOBIN/waybackurls" "$SEHARUSNYA"
            echo -e "${INFO} waybackurls berhasil terinstall."
        else
            echo -e "${RED}Gagal menemukan waybackurls di ${GOBIN}.${RESET}"
        fi
        ;;

    11)
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
