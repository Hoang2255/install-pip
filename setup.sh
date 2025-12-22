#!/data/data/com.termux/files/usr/bin/bash
echo "FIX LỖI"

yes | pkg update -y && yes | pkg upgrade -y
clear

# ====== KHAI BÁO MÀU SẮC ======
DO='\033[1;31m'
CAM_NHAT='\033[1;33m' # Màu cam vàng nhạt
XANH_DUONG='\033[1;36m'
XANH_LA='\033[1;32m'
TRANG='\033[1;37m'
RESET='\033[0m'

# ====== LOGO HOANGPC (MÀU ĐỎ) ======
echo -e "${DO}"
echo "██╗  ██╗ ██████╗  █████╗ ███╗   ██╗ ██████╗ ██████╗  ██████╗"
echo "██║  ██║██╔═══██╗██╔══██╗████╗  ██║██╔════╝ ██╔══██╗██╔════╝"
echo "███████║██║   ██║███████║██╔██╗ ██║██║  ███╗██████╔╝██║     "
echo "██╔══██║██║   ██║██╔══██║██║╚██╗██║██║   ██║██╔═══╝ ██║     "
echo "██║  ██║╚██████╔╝██║  ██║██║ ╚████║╚██████╔╝██║     ╚██████╗"
echo "╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝      ╚═════╝"
echo -e "${RESET}"

# Dòng chữ Khởi tạo chuyển sang màu Cam nhạt
echo -e "${CAM_NHAT}🚀 KHỞI TẠO MÔI TRƯỜNG PYTHON 3.11${RESET}"
sleep 1

# ====== HÀM THANH CHẠY (BẢN ỔN ĐỊNH NHẤT) ======
progress_bar() {
  pid=$1
  text="$2"
  
  spin='-\|/'
  i=0
  
  while kill -0 "$pid" 2>/dev/null; do
    i=$(( (i+1) %4 ))
    printf "\r${XANH_DUONG}⏳ [${spin:$i:1}] %-20s ${RESET}" "$text..."
    sleep 0.1
  done

  printf "\r${XANH_LA}✔  %-20s ${TRANG}[HOÀN TẤT]${RESET}\n" "$text"
}

# ====== CÁC BƯỚC CÀI ĐẶT ======

# 1. UPDATE
yes | pkg update -y > /dev/null 2>&1 &
progress_bar $! "Update system"

# 2. UPGRADE
yes | pkg upgrade -y > /dev/null 2>&1 &
progress_bar $! "Upgrade system"

# 3. STORAGE
yes | termux-setup-storage > /dev/null 2>&1 &
progress_bar $! "Setup storage"

# 4. CÀI GÓI CƠ BẢN
pkg install python php git wget -y > /dev/null 2>&1 &
progress_bar $! "Install packages"

# 5. HẠ PYTHON (3.11)
curl -fsSL https://raw.githubusercontent.com/Hoang2255/install-pip/refs/heads/main/setup-python3.11 \
  | bash > /dev/null 2>&1 &
progress_bar $! "Setup Python 3.11"

# 6. CÀI PIP
curl -fsSL https://raw.githubusercontent.com/Hoang2255/install-pip/refs/heads/main/install-pip.py \
  | python > /dev/null 2>&1 &
progress_bar $! "Install pip"

# 7. CÀI THƯ VIỆN PYTHON
pip install httpx fake_useragent colorama rich pycryptodome cloudscraper mechanize requests bs4 pystyle \
  > /dev/null 2>&1 &
progress_bar $! "Python libraries"

# ====== HOÀN TẤT ======
echo
# Đoạn hoàn tất chuyển sang màu Cam nhạt
echo -e "${CAM_NHAT}🎉 HOÀN TẤT CÀI ĐẶT BỞI HOANGPC 🎉${RESET}"
echo -e "${XANH_DUONG}Python:${TRANG} $(python3.11 --version)"
echo -e "${XANH_DUONG}Pip:${TRANG} $(pip --version)"
echo
