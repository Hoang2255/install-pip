# Termux Python & Pip Environment Setup Tool

Kho lưu trữ: [Hoang2255/install-pip](https://github.com/Hoang2255/install-pip)

Bộ công cụ Bash và Python script chuyên dụng cho **Termux (Android)**, hỗ trợ hạ cấp phiên bản Python (**Python 3.12.12**, **Python 3.13.13**) hoặc cài đặt song song **Python 3.11**, tự động thiết lập và khôi phục **Pip**, tối ưu hóa các module nhị phân phức tạp (`cryptography`, `pyOpenSSL`) mà không cần tốn thời gian biên dịch Rust, đồng thời bảo vệ phiên bản hệ thống chống bị ghi đè khi cập nhật.

- **Tác giả:** HoangPC
- **Momo Donate:** `0865385209`

---

## 🌟 Tính năng nổi bật

- **Đa dạng chế độ và phiên bản Python:**
  - `Python 3.12.12`: Phiên bản có độ ổn định và tương thích cao nhất cho hầu hết các tool, bot, thư viện hiện nay trên Android.
  - `Python 3.13.13`: Phiên bản mới hơn, đáp ứng các dự án yêu cầu môi trường Python 3.13.
  - `Python 3.11`: Cài đặt độc lập qua `tur-repo` để chạy song song cùng mọi phiên bản Python khác (sử dụng lệnh `python3.11` và `pip3.11`).
- **Khôi phục và cấu hình Pip độc lập (`install-pip.py`):**
  - Tích hợp bộ bootstrap Pip 24.x độc lập, giải quyết dứt điểm các lỗi mất Pip, thiếu `ensurepip`, hoặc lỗi không tìm thấy `pip` sau khi hạ cấp Python.
- **Tối ưu Cryptography & pyOpenSSL không cần biên dịch Rust:**
  - Tích hợp sẵn các gói `.deb` `cryptography` được biên dịch sẵn tối ưu theo từng kiến trúc CPU (46.0.3 cho Python 3.12 và 48.0.1 cho Python 3.13).
  - Tiết kiệm 20–30 phút so với việc phải biên dịch Rust thủ công, loại bỏ hoàn toàn nguy cơ tràn RAM hay sập ứng dụng Termux.
  - Tự động cấu hình `pyOpenSSL` tương thích với hệ thống.
- **Hỗ trợ đa kiến trúc CPU:**
  - `aarch64` (ARM 64-bit)
  - `armv7l` / `arm` / `armv8l` (ARM 32-bit & tương thích)
- **Tùy chọn cài đặt linh hoạt (Full & Lite):**
  - **Bản Full:** Tự động cài sẵn trọn bộ các thư viện phổ biến: `pillow`, `bs4`, `requests`, `pystyle`, `pycryptodome`, `colorama`, `httpx`, `urllib3`.
  - **Bản Lite:** Tinh gọn, chỉ hạ cấp Python và thiết lập môi trường cốt lõi cùng Pip, không cài thêm module bên ngoài giúp tiết kiệm tối đa dung lượng bộ nhớ.
- **Tự động tối ưu và bảo vệ môi trường Termux:**
  - Tự động cấp quyền truy cập bộ nhớ (`termux-setup-storage`).
  - Sửa lỗi các gói hỏng (`apt --fix-broken install`) và dọn sạch gói thừa (`apt autoremove`).
  - Khóa phiên bản Python (`apt-mark hold python`) giúp hệ thống không tự động nâng cấp đè phiên bản mới khi người dùng chạy `pkg upgrade`.
  - Tự động dọn dẹp các tệp tin cài đặt `.deb` tạm sau khi thiết lập xong.

---

## 📋 Yêu cầu hệ thống

- Ứng dụng **Termux** (Khuyến nghị cài đặt bản mới nhất từ [F-Droid](https://f-droid.org/packages/com.termux/) hoặc [GitHub Termux Releases](https://github.com/termux/termux-app/releases); **không** dùng bản cũ trên Google Play do không còn cập nhật repo).
- Kiến trúc CPU máy: `aarch64` hoặc `armv7l` / `arm`.
- Kết nối mạng Internet ổn định.
- Dung lượng bộ nhớ trống tối thiểu: **1.2GB – 2.3GB**.

---

## 🚀 Hướng dẫn cài đặt và sử dụng

### Cách 1: Chạy nhanh bằng 1 lệnh duy nhất (Khuyến nghị ⭐)

Mở Termux, sao chép toàn bộ dòng lệnh bên dưới, dán vào màn hình Termux và nhấn **Enter**:

```bash
curl -fsSL https://raw.githubusercontent.com/Hoang2255/install-pip/main/setup.sh | bash
```

*(Hoặc tải trực tiếp script chọn chế độ):*

```bash
curl -fsSL -o select_full_lite.sh "https://raw.githubusercontent.com/Hoang2255/install-pip/refs/heads/main/select_full%26lite.sh" && chmod +x select_full_lite.sh && bash select_full_lite.sh
```

---

### Cách 2: Cài đặt từng bước thủ công (Dễ kiểm soát)

#### Bước 1: Cập nhật gói hệ thống và cài đặt `curl`
```bash
pkg update -y && pkg install -y curl
```

#### Bước 2: Tải script khởi chạy
```bash
curl -fsSL -O https://raw.githubusercontent.com/Hoang2255/install-pip/main/setup.sh
```

#### Bước 3: Cấp quyền thực thi cho file script
```bash
chmod +x setup.sh
```

#### Bước 4: Khởi chạy script
```bash
bash setup.sh
```

---

### Cách 3: Phương án dự phòng (Khi `curl` gặp sự cố)

#### Dùng `wget` thay cho `curl`:
```bash
pkg install -y wget && wget https://raw.githubusercontent.com/Hoang2255/install-pip/main/setup.sh -O setup.sh && chmod +x setup.sh && bash setup.sh
```

#### Hoặc Clone trực tiếp Repository từ GitHub:
```bash
pkg install -y git && git clone https://github.com/Hoang2255/install-pip.git && cd install-pip && chmod +x setup.sh && bash setup.sh
```

---

### Cài đặt riêng lẻ từng tính năng

- **Chỉ cài đặt hoặc khôi phục Pip độc lập:**  
  Nếu bạn chỉ cần khôi phục lại công cụ `pip` cho phiên bản Python hiện tại trên Termux:
  ```bash
  curl -fsSL https://raw.githubusercontent.com/Hoang2255/install-pip/main/install-pip.py | python
  ```

- **Chỉ cài đặt Python 3.11 (Chạy song song):**  
  ```bash
  curl -fsSL -O https://raw.githubusercontent.com/Hoang2255/install-pip/main/setup-python3.11 && chmod +x setup-python3.11 && bash setup-python3.11
  ```

---

## 📂 Các Script và Công cụ trong Kho lưu trữ

- **`setup.sh` (hoặc `setup0.sh`):**  
  Script kích hoạt nhanh 1 dòng, tự động tải `select_full&lite.sh`, phân quyền thực thi, chạy menu cài đặt và tự xóa script trung gian sau khi hoàn thành.
- **`select_full&lite.sh`:**  
  Trình quản lý trung tâm đa năng, tự động phát hiện kiến trúc CPU (`uname -m`), yêu cầu quyền bộ nhớ (`termux-setup-storage`), sửa lỗi gói hỏng, cập nhật toàn bộ hệ thống và cung cấp menu tương tác lựa chọn giữa bản Full, bản Lite hoặc bản Python 3.11 song song.
- **`install-pip.py`:**  
  Công cụ bootstrap cài đặt Pip độc lập (bản quyền mở, phiên bản 24.x), hỗ trợ khởi tạo hoặc phục hồi môi trường Pip hoàn chỉnh trực tiếp cho Python mà không cần thông qua trình quản lý gói của hệ điều hành.
- **`setup-python3.11`:**  
  Script tự động cài đặt kho bổ trợ `tur-repo`, cài đặt môi trường `python3.11` cùng các module cơ bản (`requests`, `bs4`, `pystyle`, `urllib3`) để chạy độc lập không ảnh hưởng đến Python mặc định của máy.

---

## 🖥 Giao diện Menu lựa chọn

Khi khởi chạy script, hệ thống sẽ tự nhận diện kiến trúc CPU và hiển thị menu lựa chọn chế độ:

```text
==================================================
=========== CHỌN PHIÊN BẢN CÀI ĐẶT ===============
==================================================
1) Bản FULL : Cài đặt đầy đủ (Hạ cấp Python + Cài đặt đầy đủ Modules)
2) Bản LITE : Cài đặt tinh gọn (Chỉ hạ cấp Python, không kèm Modules)
3) Bản Python 3.11 (Cài song song cùng mọi bản python 3.12 trở lên)
0) Thoát
==================================================
Nhập lựa chọn của bạn (1, 2, 3 hoặc 0): 
```

- **Lựa chọn `1` (Bản Full):** Phù hợp nếu bạn cần ngay một môi trường đầy đủ các thư viện thông dụng để chạy tool/bot tự động.
- **Lựa chọn `2` (Bản Lite):** Phù hợp cho nhu cầu tối ưu dung lượng, chỉ cài đặt Python và Pip nguyên bản.
- **Lựa chọn `3` (Python 3.11):** Cài đặt thêm phiên bản 3.11 qua kho `tur-repo` để chạy song song (sử dụng qua lệnh `python3.11` và `pip3.11`).
- **Lựa chọn `0`:** Hủy bỏ và thoát script an toàn.

---

## ⚙️ Quy trình hoạt động của Script

1. **Nhận diện kiến trúc CPU:**  
   Kiểm tra thiết bị thông qua lệnh `uname -m` (`aarch64` hoặc `armv7l`/`arm`). Tự động dừng nếu kiến trúc phần cứng không tương thích để tránh gây hỏng môi trường Termux.
2. **Cấu hình & Tối ưu hệ thống:**  
   - Khởi tạo quyền bộ nhớ thiết bị (`termux-setup-storage`).
   - Sửa chữa tự động các gói phụ thuộc bị lỗi (`apt --fix-broken install`, `apt autoremove`).
   - Cập nhật danh sách kho ứng dụng và nâng cấp các gói nền tảng Termux (`apt update`, `apt full-upgrade`).
3. **Triển khai gói Python phù hợp:**  
   Tải trực tiếp gói nhị phân `.deb` Python chuẩn theo kiến trúc CPU đã nhận diện và tiến hành cài đặt thông qua `dpkg`.
4. **Thiết lập Pip & Gói Cryptography / pyOpenSSL tối ưu:**  
   - Chạy `install-pip.py` để nạp Pip chính xác cho môi trường Python vừa hạ cấp.
   - Cài đặt gói `.deb` Cryptography được build sẵn cho CPU tương ứng, bỏ qua bước build Rust.
   - Cài đặt `pyOpenSSL` tương thích thông qua Pip (`--no-deps`).
5. **Cài đặt Modules bổ trợ (ở chế độ Full):**  
   Tự động cài đặt danh sách module được định sẵn: `pillow`, `bs4`, `requests`, `pystyle`, `pycryptodome`, `colorama`, `httpx`, `urllib3`.
6. **Khóa phiên bản và tổng hợp thông tin:**  
   - Áp dụng lệnh `apt-mark hold python` để bảo vệ phiên bản Python đã cài.
   - Tự động xóa các file cài đặt `.deb` tạm để giải phóng bộ nhớ.
   - Hiển thị bảng tổng kết chi tiết phiên bản (`Python`, `Pip`, `Cryptography`, `pyOpenSSL`) để người dùng dễ dàng xác nhận.

---

## 🛠 Xử lý lỗi thường gặp (Troubleshooting)

| Lỗi gặp phải | Nguyên nhân | Cách khắc phục |
| :--- | :--- | :--- |
| **`curl: command not found`** | Termux chưa được cài tiện ích `curl` | Chạy lệnh: `pkg update && pkg install -y curl`. |
| **`Permission denied`** | File script chưa được cấp quyền thực thi | Chạy lệnh: `chmod +x setup.sh` hoặc gọi trực tiếp bằng `bash setup.sh`. |
| **`No such file or directory`** | Tải file bị lỗi mạng hoặc sai tên file tải về | Kiểm tra lại kết nối mạng và xem danh sách file bằng lệnh `ls -la`. |
| **`$'\r': command not found`** | File script bị dính định dạng xuống dòng Windows (CRLF) | Chạy lệnh: `sed -i -e 's/\r$//' setup.sh` rồi chạy lại `bash setup.sh`. |
| **Termux bị tắt / văng giữa chừng** | Chế độ tiết kiệm pin của Android tự đóng Termux khi chạy nền | Kéo thanh thông báo của điện thoại xuống, chọn **Acquire Wakelock** tại thông báo Termux (hoặc gõ lệnh `termux-wake-lock`). |
| **Lỗi thiếu `pip` sau khi hạ cấp** | Gói Python deb tối giản chưa kèm Pip | Chạy lệnh: `curl -fsSL https://raw.githubusercontent.com/Hoang2255/install-pip/main/install-pip.py \| python` để tự động phục hồi Pip. |

---

## ☕ Ủng hộ tác giả (Donate)

Nếu bộ công cụ này giúp ích cho công việc và học tập của bạn, bạn có thể ủng hộ tác giả một ly cà phê qua:
- **Tác giả:** HoangPC
- **Momo:** `0865385209`
