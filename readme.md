# Instalasi Tools Cyber Security Part1

Script ini adalah kumpulan tools yang berguna untuk keperluan keamanan siber. Dengan script ini, Anda dapat dengan mudah menginstal berbagai tools yang sering digunakan oleh profesional keamanan siber. 

## Fitur

- **Install Projectdiscovery Tools**: Menginstal Subfinder, Httpx, dan Nuclei.
- **Install Dalfox**: Mendukung pengujian XSS.
- **Install Sqlmap**: Alat pengujian injeksi SQL.
- **Install ParamSpider**: Mengumpulkan parameter URL untuk pengujian.
- **Install FFUF**: Fuzzer URL.
- **Install Dirsearch**: Alat untuk menemukan direktori tersembunyi.
- **Install Nmap**: Alat pemindaian jaringan.
- **Install Waybackurls**: Mengambil URL lama dari Wayback Machine.
- **Informasi Media Sosial**: Akses langsung ke Telegram, LinkedIn, dan Instagram pembuat script.

## Persyaratan

- Operating system: Debian, Ubuntu, or Kali Linux
- Root privileges
- Following packages:
  - `snap`
  - `python3-pip`
  - `golang`

## Instalasi

### Clone Repository
1. Clone repository ke lokal:
   ```bash
   git clone git@github.com:zfernm/Instalasi_Tools_Cyber_Security_Part1.git
   cd Instalasi_Tools_Cyber_Security_Part1
   ```

### Jalankan Script
1. Pastikan Anda memiliki hak akses root:
   ```bash
   sudo su
   ```
2. Ubah izin file agar bisa dieksekusi:
   ```bash
   chmod +x tools_.sh
   ```
3. Jalankan script:
   ```bash
   ./tools.sh
   ```
4. Pilih opsi yang tersedia dari menu untuk menginstal tools yang diinginkan.

## Catatan Penting

- Script ini hanya mendukung distribusi berbasis Debian (Debian, Ubuntu, Kali).
- Tools yang diinstal akan disimpan di direktori `/bin` untuk memudahkan akses.
- Golang diperlukan untuk menginstal beberapa tools seperti Subfinder, Httpx, Nuclei, Dalfox, FFUF, dan Waybackurls.

## Menu Opsi

![Output ](<Tool_Cyber_Security_Part_Satu.png>)
![Output](<Tools_Cyber_Security_Part1.png>)

## Instalasi Tools

### 1. Projectdiscovery Tools
- **Subfinder**: Mengumpulkan subdomain secara otomatis.
- **Httpx**: Melakukan pemeriksaan status HTTP pada domain.
- **Nuclei**: Menjalankan template untuk pengujian kerentanan.

### 2. Dalfox
Alat untuk mendeteksi kerentanan XSS.

### 3. Sqlmap
Pengujian injeksi SQL.

### 4. ParamSpider
Mengumpulkan parameter URL untuk pengujian kerentanan.

### 5. FFUF
Fuzzer URL untuk menemukan direktori tersembunyi.

### 6. Dirsearch
Alat untuk menemukan direktori tersembunyi pada aplikasi web.

### 7. Nmap
Pemindai jaringan untuk mendeteksi layanan aktif.

### 8. Waybackurls
Mengambil URL yang telah diarsipkan oleh Wayback Machine.

## Media Sosial

- **Telegram**: [Samuel Hamonangan S.](https://t.me/zfernm)
- **LinkedIn**: [Samuel Hamonangan S.](https://www.linkedin.com/in/samuel-hamonangan-s-099604255/)
- **Instagram**: [Samuel Hamonangan S.](https://www.instagram.com/samuellhsss)

## Lisensi

Script ini dirancang untuk membantu profesional keamanan siber. Gunakan dengan tanggung jawab penuh terhadap hukum dan etika. Tidak ada jaminan yang diberikan, dan pengguna bertanggung jawab atas penggunaan script ini.

