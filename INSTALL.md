# Installation Guide

Hướng dẫn cài đặt và build ZMK firmware cho Noru64 Split Keyboard.

## 🚀 Quick Start (Khuyến nghị)

### Sử dụng GitHub Actions
1. **Fork repository** này về GitHub
2. **Push code** lên GitHub
3. **Download firmware** từ tab "Actions" → "Artifacts"

Không cần cài đặt gì trên máy local!

## 💻 Local Build (Nâng cao)

### Yêu cầu hệ thống
- **Windows 10/11** (64-bit)
- **Git** (để clone repositories)
- **Python 3.8+** (để cài đặt west)

### Cài đặt Dependencies

#### 1. Cài đặt Python
```powershell
# Download từ https://www.python.org/downloads/
# Hoặc sử dụng chocolatey:
choco install python
```

#### 2. Cài đặt West
```powershell
pip install west
```

#### 3. Cài đặt CMake
```powershell
# Download từ https://cmake.org/download/
# Hoặc sử dụng chocolatey:
choco install cmake
```

#### 4. Cài đặt Ninja
```powershell
# Download từ https://ninja-build.org/
# Hoặc sử dụng chocolatey:
choco install ninja
```

#### 5. Cài đặt Git
```powershell
# Download từ https://git-scm.com/downloads
# Hoặc sử dụng chocolatey:
choco install git
```

### Khởi tạo Workspace

```powershell
# Clone repository
git clone https://github.com/your-username/noru64-split-keyboard.git
cd noru64-split-keyboard

# Khởi tạo west workspace
west init -l config
west update
```

### Build Firmware

#### Cách 1: Sử dụng Script (Khuyến nghị)
```powershell
# Build tất cả boards
.\build.bat

# Build board cụ thể
.\build.bat noru64_split_center
.\build.bat noru64_split_peripheral
```

#### Cách 2: Build thủ công
```powershell
# Build Center
mkdir zmk\app\build_center
cd zmk\app\build_center
cmake -G "Ninja" -DBOARD=noru64_split_center -DZMK_CONFIG="$(pwd)/config" ..
ninja
copy zephyr\zmk.uf2 ..\..\..\config\firmware_center.uf2

# Build Peripheral
mkdir zmk\app\build_peripheral
cd zmk\app\build_peripheral
cmake -G "Ninja" -DBOARD=noru64_split_peripheral -DZMK_CONFIG="$(pwd)/config" ..
ninja
copy zephyr\zmk.uf2 ..\..\..\config\firmware_peripheral.uf2
```

## 🔧 Troubleshooting

### Lỗi thường gặp

#### 1. "west not found"
```powershell
# Cài đặt west
pip install west

# Kiểm tra PATH
$env:PATH
```

#### 2. "cmake not found"
```powershell
# Cài đặt cmake
choco install cmake

# Hoặc download từ https://cmake.org/download/
# Thêm cmake vào PATH
```

#### 3. "ninja not found"
```powershell
# Cài đặt ninja
choco install ninja

# Hoặc download từ https://ninja-build.org/
# Thêm ninja vào PATH
```

#### 4. "west init" fails
```powershell
# Xóa .west folder và thử lại
Remove-Item -Recurse -Force .west
west init -l config
west update
```

#### 5. Build fails
```powershell
# Clean và build lại
Remove-Item -Recurse -Force zmk\app\build_*
.\build.bat
```

### Kiểm tra cài đặt

```powershell
# Kiểm tra Python
python --version

# Kiểm tra West
west --version

# Kiểm tra CMake
cmake --version

# Kiểm tra Ninja
ninja --version

# Kiểm tra Git
git --version
```

## 📦 Alternative: Sử dụng Chocolatey

### Cài đặt Chocolatey
```powershell
# Chạy PowerShell as Administrator
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

### Cài đặt tất cả dependencies
```powershell
# Cài đặt tất cả tools cần thiết
choco install python cmake ninja git -y

# Cài đặt west
pip install west
```

## 🚀 GitHub Actions (Khuyến nghị)

### Tại sao nên sử dụng GitHub Actions?

1. **Không cần cài đặt** gì trên máy local
2. **Tự động build** khi push code
3. **Consistent environment** - luôn build trong môi trường sạch
4. **Artifact management** - firmware được lưu trữ an toàn
5. **Build logs** - dễ debug khi có lỗi

### Cách sử dụng

1. **Fork repository** này về GitHub
2. **Enable Actions** trong repository settings
3. **Push code** lên GitHub
4. **Vào tab "Actions"** để xem build progress
5. **Download firmware** từ "Artifacts" section

### Manual Build

Bạn cũng có thể trigger build thủ công:
1. Vào tab "Actions"
2. Chọn "ZMK Firmware Build"
3. Click "Run workflow"
4. Chọn board cần build

## 📚 Tài liệu tham khảo

- [ZMK Documentation](https://zmk.dev/docs)
- [Zephyr RTOS Documentation](https://docs.zephyrproject.org/)
- [CMake Documentation](https://cmake.org/documentation/)
- [Ninja Build System](https://ninja-build.org/)
- [West Tool Documentation](https://docs.zephyrproject.org/latest/develop/west/index.html)
- [Chocolatey Package Manager](https://chocolatey.org/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
