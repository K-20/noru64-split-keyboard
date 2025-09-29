# Quick Start Guide

Hướng dẫn nhanh để sử dụng Noru64 Split Keyboard firmware.

## 🚀 Cách nhanh nhất (5 phút)

### 1. Fork Repository
1. Vào [GitHub repository](https://github.com/your-username/noru64-split-keyboard)
2. Click **"Fork"** ở góc trên bên phải
3. Chọn account để fork về

### 2. Enable Actions
1. Vào repository đã fork
2. Click tab **"Actions"**
3. Click **"I understand my workflows, go ahead and enable them"**

### 3. Push Code
1. Clone repository về máy:
   ```bash
   git clone https://github.com/your-username/noru64-split-keyboard.git
   cd noru64-split-keyboard
   ```

2. Push code lên GitHub:
   ```bash
   git add .
   git commit -m "Initial commit"
   git push origin main
   ```

### 4. Download Firmware
1. Vào tab **"Actions"** trong GitHub
2. Chọn workflow run vừa chạy
3. Scroll xuống phần **"Artifacts"**
4. Download:
   - `firmware-noru64_split_center-{commit}.uf2`
   - `firmware-noru64_split_peripheral-{commit}.uf2`

### 5. Flash Firmware
1. **Center (bên trái)**:
   - Put keyboard vào bootloader mode
   - Copy `firmware-noru64_split_center-{commit}.uf2` vào keyboard
   - Keyboard sẽ tự động flash

2. **Peripheral (bên phải)**:
   - Put keyboard vào bootloader mode
   - Copy `firmware-noru64_split_peripheral-{commit}.uf2` vào keyboard
   - Keyboard sẽ tự động flash

## ✅ Xong!

Bây giờ bạn có:
- ✅ **Center keyboard** kết nối USB với máy tính
- ✅ **Peripheral keyboard** kết nối BLE với center
- ✅ **Split keyboard** hoạt động hoàn chỉnh

## 🔧 Tùy chỉnh

### Thay đổi Keymap
1. Chỉnh sửa file `config/keymap.json`
2. Push code lên GitHub
3. Download firmware mới từ Actions

### Thay đổi Layout
1. Chỉnh sửa file `config/info.json`
2. Push code lên GitHub
3. Download firmware mới từ Actions

## 🐛 Troubleshooting

### Build fails
- Kiểm tra logs trong tab "Actions"
- Đảm bảo code không có syntax errors

### Keyboard không kết nối
- Đảm bảo đã flash firmware cho cả hai thiết bị
- Reset cả hai thiết bị nếu cần
- Kiểm tra pin của peripheral

### Không download được firmware
- Đảm bảo build thành công
- Kiểm tra quyền truy cập repository

## 📚 Tài liệu chi tiết

- [README.md](README.md) - Hướng dẫn đầy đủ
- [GITHUB_ACTIONS.md](GITHUB_ACTIONS.md) - Chi tiết về GitHub Actions
- [LOCAL_BUILD.md](LOCAL_BUILD.md) - Build trên máy local
- [INSTALL.md](INSTALL.md) - Cài đặt dependencies

## 🆘 Hỗ trợ

Nếu gặp vấn đề:
1. Kiểm tra [Issues](https://github.com/your-username/noru64-split-keyboard/issues)
2. Tạo issue mới nếu chưa có
3. Mô tả chi tiết vấn đề gặp phải

---

**Chúc bạn sử dụng vui vẻ! 🎉**
