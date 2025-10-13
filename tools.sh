#!/bin/bash

# ======== Styling ========
RED="\e[31m"
GREEN="\e[1;32m"
BLUE="\e[1;34m"
MAGENTA="\e[35m"
RESET="\e[0m"
INFO="${GREEN}[ INFO ]${RESET}"
PROSES="${BLUE}[ PROSES ]${RESET}"
ERR="${RED}[ ERROR ]${RESET}"

# ======== Env & PATH ========
# Pakai Go yang diinstall manual di /usr/local/go (hindari golang-go dari apt)
export PATH=/usr/local/go/bin:$PATH
export GOPATH="${GOPATH:-$HOME/go}"
export GOBIN="${GOBIN:-$GOPATH/bin}"
export PATH="$PATH:$GOBIN"
SEHARUSNYA="/usr/local/bin"

TELEGRAM="https://t.me/zfernm"
LINKEDIN="https://www.linkedin.com/in/samuel-hamonangan-s-099604255/"
INSTAGRAM="https://www.instagram.com/samuellhsss"

# ======== Logo ========
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

# ======== Guards ========
if [[ $EUID -ne 0 ]]; then
    echo -e "${ERR} Anda harus menjalankan script sebagai root."
    exit 1
fi

OS=$(lsb_release -is 2>/dev/null || echo "Unknown")
case "$OS" in
  Debian|Ubuntu|Kali|LinuxMint) : ;;
  *) echo -e "${ERR} Script hanya untuk Debian/Ubuntu/Kali/LinuxMint."; exit 1 ;;
esac

# ======== Helpers ========
version_ge() { # usage: version_ge 1.24.0 1.20.0
  # returns true if $1 >= $2
  [[ "$(printf '%s\n' "$2" "$1" | sort -V | head -n1)" == "$2" ]]
}

ensure_go() {
  if ! command -v go >/dev/null 2>&1; then
    echo -e "${ERR} Go tidak ditemukan di PATH."
    echo -e "${INFO} Pastikan sudah install Go ke /usr/local/go dan PATH berisi /usr/local/go/bin."
    echo -e "${INFO} Cek: wget https://go.dev/dl/go1.24.1.linux-amd64.tar.gz && sudo tar -C /usr/local -xzf go1.24.1.linux-amd64.tar.gz"
    exit 1
  fi
  local GOV
  GOV="$(go version | awk '{print $3}' | sed 's/go//')"
  if ! version_ge "$GOV" "1.20.0"; then
    echo -e "${ERR} Go minimal 1.20.0 diperlukan. Versi saat ini: $GOV"
    echo -e "${INFO} Update Go di /usr/local/go, lalu jalankan ulang script."
    exit 1
  fi
  mkdir -p "$GOBIN"
}

go_get_and_place() { # usage: go_get_and_place <module@version> <binary_name>
  local module="$1"
  local bin="$2"
  echo -e "${PROSES} go install ${module}"
  if /usr/bin/env bash -lc "go install ${module}"; then
    if [[ -f "$GOBIN/$bin" ]]; then
      mv "$GOBIN/$bin" "$SEHARUSNYA" && \
        echo -e "${INFO} ${bin} dipindahkan ke ${SEHARUSNYA}" || \
        echo -e "${ERR} Gagal memindahkan ${bin} ke ${SEHARUSNYA}. Cek permission."
    else
      echo -e "${ERR} ${bin} tidak ditemukan di ${GOBIN} setelah install. Cek PATH/Go env."
    fi
  else
    echo -e "${ERR} go install gagal untuk ${bin}."
    echo -e "${INFO} Tips: kamu bisa pakai binary release GitHub kalau butuh cepat."
  fi
}

# ======== System deps (tanpa golang-go agar tidak bentrok) ========
apt update && apt upgrade -y
apt install -y snap snapd python3-pip git unzip curl ca-certificates

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

case "$pilihan" in
  1)
    echo -e "${PROSES} Menginstall Subfinder..."
    ensure_go
    go_get_and_place "github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest" "subfinder"
    ;;

  2)
    echo -e "${PROSES} Menginstall HTTPX..."
    ensure_go
    go_get_and_place "github.com/projectdiscovery/httpx/cmd/httpx@latest" "httpx"
    ;;

  3)
    echo -e "${PROSES} Menginstall Nuclei..."
    ensure_go
    go_get_and_place "github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest" "nuclei"
    ;;

  4)
    echo -e "${PROSES} Menginstall dalfox..."
    ensure_go
    go_get_and_place "github.com/hahwul/dalfox/v2@latest" "dalfox"
    ;;

  5)
    echo -e "${PROSES} Menginstall sqlmap..."
    if command -v snap >/dev/null 2>&1; then
      snap install sqlmap && echo -e "${INFO} sqlmap berhasil terinstall via snap."
    else
      echo -e "${PROSES} snap tidak ditemukan, menginstall sqlmap via git..."
      git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git /opt/sqlmap
      ln -sf /opt/sqlmap/sqlmap.py /usr/local/bin/sqlmap
      echo -e "${INFO} sqlmap di-clone ke /opt/sqlmap dan symlink dibuat."
    fi
    ;;

  6)
    echo -e "${PROSES} Menginstall ParamSpider..."
    set -e
    mkdir -p /root/tools
    if [[ -d /root/tools/ParamSpider ]]; then
      echo -e "${INFO} Folder ParamSpider sudah ada. Menghapus & reinstall..."
      rm -rf /root/tools/ParamSpider
    fi
    git clone https://github.com/devanshbatham/ParamSpider /root/tools/ParamSpider
    cd /root/tools/ParamSpider
    if [[ -f requirements.txt ]]; then
      pip3 install -r requirements.txt
    else
      echo -e "${ERR} requirements.txt tidak ditemukan! Menginstall dependensi dasar..."
      pip3 install certifi==2020.4.5.1 chardet==3.0.4 idna==2.9 requests==2.23.0 urllib3==1.25.8
    fi
    set +e
    echo -e "${INFO} ParamSpider berhasil terinstall."
    ;;

  7)
    echo -e "${PROSES} Menginstall FFUF..."
    ensure_go
    go_get_and_place "github.com/ffuf/ffuf@latest" "ffuf"
    ;;

  8)
    echo -e "${PROSES} Menginstall Dirsearch..."
    mkdir -p ~/tools
    if [[ -d ~/tools/dirsearch ]]; then
      echo -e "${INFO} Repo dirsearch sudah ada. Mengupdate..."
      cd ~/tools/dirsearch && git pull --ff-only
    else
      git clone https://github.com/maurosoria/dirsearch.git ~/tools/dirsearch
    fi
    echo -e "${INFO} Dirsearch siap di ~/tools/dirsearch (jalankan python3 dirsearch.py -u <url>)."
    ;;

  9)
    echo -e "${PROSES} Menginstall NMAP..."
    apt install -y nmap && echo -e "${INFO} NMAP berhasil terinstall."
    ;;

  10)
    echo -e "${PROSES} Menginstall Waybackurls..."
    ensure_go
    go_get_and_place "github.com/tomnomnom/waybackurls@latest" "waybackurls"
    ;;

  11)
    echo -e "${MAGENTA} Telegram: ${TELEGRAM}${RESET}"
    echo -e "${MAGENTA} LinkedIn: ${LINKEDIN}${RESET}"
    echo -e "${MAGENTA} Instagram: ${INSTAGRAM}${RESET}"
    ;;

  x|X)
    exit 0
    ;;

  *)
    echo -e "${ERR} Pilihan tidak valid. Silakan pilih opsi yang tersedia."
    ;;
esac
