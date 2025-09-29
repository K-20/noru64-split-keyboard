# Noru64 Split Keyboard - ZMK Configuration

Đây là cấu hình ZMK cho bàn phím split Noru64 với thiết bị bên trái làm center và thiết bị bên phải làm peripheral.

## Cấu trúc Project

```
noru64_split/
├── config/
│   ├── boards/arm/noru64_split/
│   │   ├── noru64_split_center.dts          # Cấu hình cho thiết bị center (bên trái)
│   │   ├── noru64_split_peripheral.dts      # Cấu hình cho thiết bị peripheral (bên phải)
│   │   ├── noru64_split.dtsi                # Cấu hình chung
│   │   ├── noru64_split_center_pinctrl.dtsi # Pin control cho center
│   │   ├── noru64_split_peripheral_pinctrl.dtsi # Pin control cho peripheral
│   │   ├── noru64_split_center_defconfig    # Defconfig cho center
│   │   ├── noru64_split_peripheral_defconfig # Defconfig cho peripheral
│   │   ├── Kconfig, Kconfig.board, Kconfig.defconfig # Cấu hình Kconfig
│   │   ├── board.cmake                      # Cấu hình build
│   │   ├── noru64_split.yaml, noru64_split.yml # Metadata
│   │   └── *.keymap                        # Keymap files
│   ├── info.json                           # Layout information
│   ├── keymap.json                         # Keymap configuration
│   ├── west.yml                            # West manifest
│   ├── noru64_split_center.conf            # Config cho center
│   └── noru64_split_peripheral.conf        # Config cho peripheral
├── build.yaml                              # GitHub Actions build matrix
└── README.md                               # Hướng dẫn này
```

## Tính năng

- **Split Keyboard**: Thiết bị bên trái là center, bên phải là peripheral
- **Bluetooth Low Energy (BLE)**: Kết nối không dây giữa hai nửa
- **RGB Underglow**: Hỗ trợ đèn LED WS2812
- **Battery Monitoring**: Theo dõi pin cho cả hai thiết bị
- **USB Connectivity**: Kết nối USB cho center
- **3 Layers**: Default, Function, và Control layers

## Cài đặt và Build

### 🚀 GitHub Actions (Khuyến nghị)

**Không cần cài đặt gì trên máy local!** Project này có GitHub Actions được cấu hình sẵn để tự động build firmware:

1. **Fork repository này** về GitHub account của bạn
2. **Push code lên GitHub** - Actions sẽ tự động build
3. **Download firmware** từ tab "Actions" → "Artifacts" sau khi build hoàn thành

#### Workflow Features:
- ✅ **Tự động build** khi push code
- ✅ **Build cho cả 2 board** (center + peripheral)
- ✅ **Upload firmware artifacts** (.uf2 files)
- ✅ **Build logs** khi có lỗi
- ✅ **Release automation** khi tạo tag
- ✅ **Không cần cài đặt** Zephyr SDK, CMake, Ninja

### 💻 Build Local

#### Yêu cầu

- Zephyr SDK
- West tool
- Python 3.8+

#### Cài đặt

1. Clone repository này
2. Khởi tạo west workspace:
   ```bash
   west init -l config
   west update
   ```

#### Build

##### Build cho Center (bên trái):
```bash
west build -p -b noru64_split_center app -- -DZMK_CONFIG="$(pwd)/config"
```

##### Build cho Peripheral (bên phải):
```bash
west build -p -b noru64_split_peripheral app -- -DZMK_CONFIG="$(pwd)/config"
```

#### Flash Firmware

Sau khi build thành công, flash firmware vào từng thiết bị:

```bash
# Flash center
west flash -b noru64_split_center

# Flash peripheral  
west flash -b noru64_split_peripheral
```

## Cấu hình Keymap

Keymap được định nghĩa trong các file:
- `config/boards/arm/noru64_split/noru64_split.keymap` - Keymap chung
- `config/keymap.json` - Cấu hình keymap JSON

### Layers

1. **Default Layer**: Các phím cơ bản
2. **Function Layer**: F1-F12, media controls, RGB controls
3. **Control Layer**: Bluetooth controls, bootloader, power management

### Key Bindings

- `Fn` (mo 1): Chuyển sang Function layer
- `Fn` (mo 2): Chuyển sang Control layer
- `Space`: Space bar (cả hai nửa)
- `Shift`, `Ctrl`, `Alt`: Modifier keys
- `Enter`, `Backspace`: Các phím chức năng

## Kết nối

1. Flash firmware cho center trước
2. Flash firmware cho peripheral sau
3. Center sẽ tự động kết nối với peripheral qua BLE
4. Kết nối center với máy tính qua USB

## Troubleshooting

### Build Issues

- Đảm bảo đã cài đặt đầy đủ Zephyr SDK
- Kiểm tra west version: `west --version`
- Xóa build folder và build lại nếu có lỗi

### Connection Issues

- Đảm bảo cả hai thiết bị đã được flash firmware
- Reset cả hai thiết bị nếu không kết nối được
- Kiểm tra pin của peripheral

## Tùy chỉnh

### Thay đổi Keymap

Chỉnh sửa file `config/boards/arm/noru64_split/noru64_split.keymap` hoặc `config/keymap.json`

### Thay đổi Pin Configuration

Chỉnh sửa các file `.dts` và `.dtsi` trong thư mục `config/boards/arm/noru64_split/`

### Thay đổi Build Configuration

Chỉnh sửa các file `*_defconfig` và `*.conf`

## License

MIT License - Xem file LICENSE để biết thêm chi tiết.

## 🔧 GitHub Actions Workflows

### Workflow Files

- **`.github/workflows/zmk-build.yml`** - Main build workflow
- **`.github/workflows/release.yml`** - Release automation
- **`.github/workflows/build.yml`** - Simple build workflow

### Cách sử dụng GitHub Actions

1. **Fork repository** này về GitHub account của bạn
2. **Enable Actions** trong repository settings
3. **Push code** - Actions sẽ tự động chạy
4. **Download firmware** từ tab "Actions" → "Artifacts"

### Manual Trigger

Bạn có thể trigger build thủ công:
1. Vào tab "Actions" trong GitHub
2. Chọn "ZMK Firmware Build"
3. Click "Run workflow"
4. Chọn board cần build (hoặc "all")

### Build Matrix

Workflow sẽ build cho:
- `noru64_split_center` - Left side (Center)
- `noru64_split_peripheral` - Right side (Peripheral)

### Artifacts

Sau khi build thành công, bạn sẽ có:
- `firmware-noru64_split_center-{commit}.uf2`
- `firmware-noru64_split_peripheral-{commit}.uf2`
- `build-info.md` - Thông tin build

## 📋 Troubleshooting

### GitHub Actions Issues

- **Build fails**: Kiểm tra logs trong tab "Actions"
- **Missing artifacts**: Đảm bảo build thành công
- **Permission errors**: Kiểm tra repository permissions

### Local Build Issues

- Đảm bảo đã cài đặt đầy đủ Zephyr SDK
- Kiểm tra west version: `west --version`
- Xóa build folder và build lại nếu có lỗi

### Connection Issues

- Đảm bảo cả hai thiết bị đã được flash firmware
- Reset cả hai thiết bị nếu không kết nối được
- Kiểm tra pin của peripheral

## Tài liệu tham khảo

- [ZMK Documentation](https://zmk.dev/docs)
- [Zephyr RTOS Documentation](https://docs.zephyrproject.org/)
- [West Tool Documentation](https://docs.zephyrproject.org/latest/develop/west/index.html)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
