# Local Build Guide

Hướng dẫn build firmware ZMK cho Noru64 Split Keyboard trên máy local.

## 🛠️ Yêu cầu hệ thống

### Windows
- **Windows 10/11** (64-bit)
- **PowerShell 5.1+** hoặc **Command Prompt**
- **Git** (để clone repositories)
- **Python 3.8+** (để cài đặt west)

### Dependencies
- **CMake 3.20+**
- **Ninja** (build system)
- **Zephyr SDK** (sẽ được cài đặt tự động)

## 📦 Cài đặt

### 1. Cài đặt Python và West
```powershell
# Cài đặt Python (nếu chưa có)
# Download từ https://www.python.org/downloads/

# Cài đặt west
pip install west
```

### 2. Cài đặt CMake và Ninja
```powershell
# Cài đặt CMake
# Download từ https://cmake.org/download/

# Cài đặt Ninja
# Download từ https://ninja-build.org/
# Hoặc sử dụng chocolatey:
choco install ninja
```

### 3. Khởi tạo workspace
```powershell
# Vào thư mục project
cd C:\path\to\noru64_split

# Khởi tạo west workspace
west init -l config
west update
```

## 🚀 Build Firmware

### Cách 1: Sử dụng Script (Khuyến nghị)

#### PowerShell Script
```powershell
# Build tất cả boards
.\build.ps1

# Build board cụ thể
.\build.ps1 noru64_split_center
.\build.ps1 noru64_split_peripheral

# Clean và build lại
.\build.ps1 all -Clean
```

#### Batch Script
```cmd
# Build tất cả boards
build.bat

# Build board cụ thể
build.bat noru64_split_center
build.bat noru64_split_peripheral
```

### Cách 2: Build thủ công

#### 1. Build Center (bên trái)
```powershell
# Tạo build directory
mkdir zmk\app\build_center
cd zmk\app\build_center

# Configure
cmake -G "Ninja" -DBOARD=noru64_split_center -DZMK_CONFIG="C:\path\to\config" ..

# Build
ninja

# Copy firmware
copy zephyr\zmk.uf2 ..\..\..\config\firmware_center.uf2
```

#### 2. Build Peripheral (bên phải)
```powershell
# Tạo build directory
mkdir zmk\app\build_peripheral
cd zmk\app\build_peripheral

# Configure
cmake -G "Ninja" -DBOARD=noru64_split_peripheral -DZMK_CONFIG="C:\path\to\config" ..

# Build
ninja

# Copy firmware
copy zephyr\zmk.uf2 ..\..\..\config\firmware_peripheral.uf2
```

## 📁 Cấu trúc Build

```
noru64_split/
├── config/
│   ├── firmware_center.uf2      # Firmware cho center
│   ├── firmware_peripheral.uf2  # Firmware cho peripheral
│   └── ...
├── zmk/
│   └── app/
│       ├── build_center/        # Build directory cho center
│       ├── build_peripheral/    # Build directory cho peripheral
│       └── ...
└── build.ps1                    # PowerShell build script
```

## 🔧 Troubleshooting

### Lỗi thường gặp

#### 1. "cmake not found"
```powershell
# Cài đặt CMake và thêm vào PATH
# Hoặc sử dụng chocolatey:
choco install cmake
```

#### 2. "ninja not found"
```powershell
# Cài đặt Ninja và thêm vào PATH
# Hoặc sử dụng chocolatey:
choco install ninja
```

#### 3. "west not found"
```powershell
# Cài đặt west
pip install west
```

#### 4. "Zephyr SDK not found"
```powershell
# West sẽ tự động cài đặt Zephyr SDK
# Nếu vẫn lỗi, thử:
west update
```

#### 5. Build fails
```powershell
# Clean và build lại
.\build.ps1 all -Clean

# Hoặc xóa build directories thủ công
Remove-Item -Recurse -Force zmk\app\build_*
```

### Debug Build

#### 1. Kiểm tra cấu hình
```powershell
# Kiểm tra west workspace
west list

# Kiểm tra board configuration
west build --board noru64_split_center --dry-run app -- -DZMK_CONFIG="$(pwd)/config"
```

#### 2. Xem build logs
```powershell
# Build với verbose output
ninja -v

# Xem cmake configuration
cmake -G "Ninja" -DBOARD=noru64_split_center -DZMK_CONFIG="$(pwd)/config" .. --debug-output
```

## 📊 Build Output

### Thành công
```
=== Build Summary ===
Successful builds: 2/2

Firmware files available in: C:\path\to\config
  - firmware_noru64_split_center.uf2
  - firmware_noru64_split_peripheral.uf2

🎉 All builds completed successfully!
```

### Thất bại
```
❌ Build failed for noru64_split_center
Configuration failed for noru64_split_center
```

## 🚀 Flash Firmware

Sau khi build thành công, flash firmware vào keyboard:

### 1. Center (bên trái)
1. Put keyboard vào bootloader mode
2. Copy `firmware_noru64_split_center.uf2` vào keyboard
3. Keyboard sẽ tự động flash

### 2. Peripheral (bên phải)
1. Put keyboard vào bootloader mode
2. Copy `firmware_noru64_split_peripheral.uf2` vào keyboard
3. Keyboard sẽ tự động flash

## 🔄 Continuous Build

### Tự động build khi thay đổi code
```powershell
# Sử dụng file watcher (cần cài đặt thêm)
# Hoặc sử dụng VS Code với ZMK extension
```

### Build script cho CI/CD
```powershell
# Tạo build script cho GitHub Actions
# Xem file .github/workflows/zmk-build.yml
```

## 📚 Tài liệu tham khảo

- [ZMK Documentation](https://zmk.dev/docs)
- [Zephyr RTOS Documentation](https://docs.zephyrproject.org/)
- [CMake Documentation](https://cmake.org/documentation/)
- [Ninja Build System](https://ninja-build.org/)
- [West Tool Documentation](https://docs.zephyrproject.org/latest/develop/west/index.html)
