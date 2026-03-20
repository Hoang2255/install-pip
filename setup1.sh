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
(cd && yes | pkg upgrade python-pip php wget git -y && apt --fix-broken install) > /dev/null 2>&1 &
progress_bar $! "Install packages"

# 5. HẠ PYTHON (3.12)
(curl -fsSL https://github.com/Hoang2255/install-pip/raw/refs/heads/main/python_3.12.12_aarch64.deb | tee python_3.12.12_aarch64.deb > /dev/null && dpkg -i python_3.12.12_aarch64.deb && pkg uninstall python-ensurepip-wheels -y) > /dev/null 2>&1 &
progress_bar $! "Setup Python 3.12"

# 6. CÀI PIP
(apt-mark hold python && curl -fsSL https://raw.githubusercontent.com/Hoang2255/install-pip/refs/heads/main/install-pip.py | python) > /dev/null 2>&1 &
progress_bar $! "Install pip3.11"

# 7. CÀI THƯ VIỆN PYTHON
(curl -fsSL https://github.com/Hoang2255/install-pip/raw/refs/heads/main/python-cryptography_46.0.3_aarch64.deb | tee python-cryptography_46.0.3_aarch64.deb > /dev/null && dpkg -i python-cryptography_46.0.3_aarch64.deb && curl -fsSL https://github.com/Hoang2255/install-pip/raw/refs/heads/main/python-pycryptodomex_3.23.0-1_aarch64.deb | tee python-pycryptodomex_3.23.0-1_aarch64.deb > /dev/null && dpkg -i python-pycryptodomex_3.23.0-1_aarch64.deb && pip install pyopenssl --no-deps && pip install bs4 requests pystyle colorama httpx urllib3) > /dev/null 2>&1 &
progress_bar $! "Python libraries"

# ====== HOÀN TẤT ======
echo
echo -e "${CAM_NHAT}🎉 HOÀN TẤT CÀI ĐẶT BỞI HOANGPC 🎉${RESET}"
echo -e "${XANH_DUONG}Python chính:${TRANG} $(python --version)"
echo -e "${XANH_DUONG}Pip:${TRANG} $(pip --version)"
echo -e "${DO}Hoàn tất cài đặt(HoangPC)"
