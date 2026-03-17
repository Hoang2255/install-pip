#!/data/data/com.termux/files/usr/bin/bash
echo "FIX LỖI"

yes | pkg update -y && yes | pkg upgrade -y
clear

# ====== KHAI BÁO MÀU SẮC ======
DO='\033[1;31m'
CAM_NHAT='\033[1;33m' 
XANH_DUONG='\033[1;36m'
XANH_LA='\033[1;32m'
TRANG='\033[1;37m'
RESET='\033[0m'

# ====== LOGO HOANGPC ======
echo -e "${DO}"
echo "██╗  ██╗ ██████╗  █████╗ ███╗   ██╗ ██████╗ ██████╗  ██████╗"
echo "██║  ██║██╔═══██╗██╔══██╗████╗  ██║██╔════╝ ██╔══██╗██╔════╝"
echo "███████║██║   ██║███████║██╔██╗ ██║██║  ███╗██████╔╝██║     "
echo "██╔══██║██║   ██║██╔══██║██║╚██╗██║██║   ██║██╔═══╝ ██║     "
echo "██║  ██║╚██████╔╝██║  ██║██║ ╚████║╚██████╔╝██║     ╚██████╗"
echo "╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝      ╚═════╝"
echo -e "${RESET}"

echo -e "${CAM_NHAT}🚀 KHỞI TẠO MÔI TRƯỜNG PYTHON 3.11/PYTHON3.12/PHP${RESET}"
sleep 1

# ====== HÀM THANH CHẠY ======
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
(pkg install php git wget pkg-config openssl python-pip rust clang -y && wget https://github.com/Hoang2255/install-pip/raw/refs/heads/main/python_3.12.12_aarch64.deb && dpkg -i python_3.12.12_aarch64.deb && rm -rf python_3.12.12_aarch64.deb) > /dev/null 2>&1 &
progress_bar $! "Install packages"

# 5. HẠ PYTHON (3.11)
curl -fsSL https://raw.githubusercontent.com/Hoang2255/install-pip/refs/heads/main/setup-python3.11 | bash > /dev/null 2>&1 &
progress_bar $! "Setup Python 3.11"

# 6. CÀI PIP (Đã thêm lệnh của bạn vào đây)
(python3.11 -m pip install --upgrade pip && curl -fsSL https://raw.githubusercontent.com/Hoang2255/install-pip/refs/heads/main/install-pip.py | python) > /dev/null 2>&1 &
progress_bar $! "Install pip3.11"

# 7. CÀI THƯ VIỆN PYTHON (Lưu ý: Dùng python3.11 -m pip để cài thẳng vào bản 3.11)
(python3.11 -m pip install httpx fake_useragent colorama rich pycryptodome cloudscraper mechanize requests bs4 pystyle && pip install requests bs4 pystyle pycryptodome colorama rich urllib3) > /dev/null 2>&1 &
progress_bar $! "Python libraries"

# ====== HOÀN TẤT ======
echo
echo -e "${CAM_NHAT}🎉 HOÀN TẤT CÀI ĐẶT BỞI HOANGPC 🎉${RESET}"
echo -e "${XANH_DUONG}Python chính:${TRANG} $(python --version)"
echo -e "${XANH_DUONG}Python phụ:${TRANG} $(python3.11 --version)"
echo -e "${XANH_DUONG}Pip:${TRANG} $(pip --version)"
echo -e "${XANH_DUONG}Pip:${TRANG} $(pip3.11 --version)"
echo -e "${DO}Sử dụng lệnh python3.11 để chạy file và sử dụng pip3.11 để cài module"
