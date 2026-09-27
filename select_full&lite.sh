#!/usr/bin/env bash

# ==============================================================================
# Script: select_full&lite.sh
# Mục đích: Menu lựa chọn giữa bản Full và bản Lite, tự động cấp quyền bộ nhớ,
#           sửa lỗi gói hệ thống, cập nhật toàn diện Termux và chuyển tiếp.
# Tác giả: HoangPC
# Donate qua Momo: 0865385209
# ==============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd)"

# 1. Kiểm tra kiến trúc máy
ARCH="$(uname -m)"
echo "===== KIỂM TRA KIẾN TRÚC MÁY ====="
echo "Kiến trúc máy hiện tại: $ARCH"

case "$ARCH" in
    aarch64|armv7l|arm|armv8l)
        echo "Kiến trúc hợp lệ: $ARCH"
        ;;
    *)
        echo "Lỗi: Kiến trúc không được hỗ trợ: $ARCH"
        exit 1
        ;;
esac

# 2. Hiển thị menu chọn phiên bản cài đặt (vòng lặp đảm bảo lựa chọn lại nếu nhập sai)
while true; do
    echo ""
    echo "=================================================="
    echo "===== CHỌN PHIÊN BẢN CÀI ĐẶT (FULL HOẶC LITE) ====="
    echo "=================================================="
    echo "1) Bản FULL : Cài đặt đầy đủ (Hạ cấp Python + Cài đặt đầy đủ Modules)"
    echo "2) Bản LITE : Cài đặt tinh gọn (Chỉ hạ cấp Python, không kèm Modules)"
    echo "0) Thoát"
    echo "=================================================="
    read -rp "Nhập lựa chọn của bạn (1, 2 hoặc 0): " mode_choice

    case "$mode_choice" in
        1)
            SELECTED_MODE="FULL"
            SCRIPT_NAME="setup_and_select.sh"
            SCRIPT_URL="https://raw.githubusercontent.com/Hoang2255/python3.xx/refs/heads/main/setup_and_select.sh"
            break
            ;;
        2)
            SELECTED_MODE="LITE"
            SCRIPT_NAME="setup_and_select_lite.sh"
            SCRIPT_URL="https://raw.githubusercontent.com/Hoang2255/python3.xx/refs/heads/main/setup_and_select_lite.sh"
            break
            ;;
        0)
            echo "Thoát chương trình."
            exit 0
            ;;
        *)
            echo ""
            echo "Lỗi: Lựa chọn không hợp lệ, vui lòng nhập lại!"
            ;;
    esac
done

# 3. Cấu hình hệ thống và chuẩn bị môi trường
clear
echo "=================================================="
echo "===== CẤU HÌNH HỆ THỐNG VÀ CHUẨN BỊ MÔI TRƯỜNG ====="
echo "Chế độ đã chọn: Bản $SELECTED_MODE"
echo "=================================================="

# 3.1. Cấp quyền truy cập bộ nhớ Termux
echo ""
echo "[1/3] Đang yêu cầu cấp quyền truy cập bộ nhớ..."
termux-setup-storage

# 3.2. Sửa lỗi và dọn dẹp các gói hệ thống
echo ""
echo "[2/3] Đang sửa lỗi và dọn dẹp các gói hệ thống..."
apt autoremove -y && apt --fix-broken install

# 3.3. Cập nhật toàn diện kho ứng dụng và hệ thống
echo ""
echo "[3/3] Đang cập nhật toàn diện hệ thống Termux..."
yes | apt update -y && yes | apt full-upgrade -y

echo ""
echo "=================================================="
echo "Cấu hình và cập nhật môi trường hoàn tất!"
echo "=================================================="

# 4. Tự động chuyển tiếp tới script đã chọn
echo ""
echo "===== TIẾN TỚI KHỞI CHẠY BẢN $SELECTED_MODE ====="

TARGET_RUN=""

# 4.1. Ưu tiên kiểm tra file script có sẵn trên máy (thư mục hiện tại hoặc thư mục con Downgrade_full/Downgrade_lite)
if [ -n "$SCRIPT_DIR" ] && [ -f "$SCRIPT_DIR/$SCRIPT_NAME" ]; then
    TARGET_RUN="$SCRIPT_DIR/$SCRIPT_NAME"
elif [ -n "$SCRIPT_DIR" ] && [ -f "$SCRIPT_DIR/Downgrade_full/$SCRIPT_NAME" ]; then
    TARGET_RUN="$SCRIPT_DIR/Downgrade_full/$SCRIPT_NAME"
elif [ -n "$SCRIPT_DIR" ] && [ -f "$SCRIPT_DIR/Downgrade_lite/$SCRIPT_NAME" ]; then
    TARGET_RUN="$SCRIPT_DIR/Downgrade_lite/$SCRIPT_NAME"
elif [ -f "./$SCRIPT_NAME" ]; then
    TARGET_RUN="./$SCRIPT_NAME"
elif [ -f "./Downgrade_full/$SCRIPT_NAME" ]; then
    TARGET_RUN="./Downgrade_full/$SCRIPT_NAME"
elif [ -f "./Downgrade_lite/$SCRIPT_NAME" ]; then
    TARGET_RUN="./Downgrade_lite/$SCRIPT_NAME"
fi

# 4.2. Nếu chưa có trên máy, tự động tải bản mới nhất từ GitHub
if [ -z "$TARGET_RUN" ]; then
    echo "Không tìm thấy $SCRIPT_NAME trên máy, đang tải từ GitHub..."
    echo "URL: $SCRIPT_URL"
    TARGET_PATH="${SCRIPT_DIR:-.}/$SCRIPT_NAME"
    if curl -# -fsSL "$SCRIPT_URL" -o "$TARGET_PATH"; then
        TARGET_RUN="$TARGET_PATH"
    fi
fi

# 4.3. Khởi chạy script tương ứng
if [ -n "$TARGET_RUN" ] && [ -f "$TARGET_RUN" ]; then
    chmod +x "$TARGET_RUN"
    echo "Khởi chạy script: $TARGET_RUN..."
    echo ""
    bash "$TARGET_RUN"
else
    echo "Lỗi: Không tìm thấy và không thể tải $SCRIPT_NAME từ GitHub!"
    exit 1
fi
