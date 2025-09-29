# GitHub Actions Setup Guide

Hướng dẫn chi tiết về cách sử dụng GitHub Actions cho project Noru64 Split Keyboard.

## 🚀 Quick Start

### 1. Fork Repository
1. Vào [GitHub repository](https://github.com/your-username/noru64-split-keyboard)
2. Click "Fork" ở góc trên bên phải
3. Chọn account để fork về

### 2. Enable Actions
1. Vào repository đã fork
2. Click tab "Actions"
3. Click "I understand my workflows, go ahead and enable them"

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

3. Actions sẽ tự động chạy và build firmware

## 📋 Workflow Details

### Main Workflow (zmk-build.yml)

**Triggers:**
- Push to main/master/develop branches
- Pull requests
- Manual dispatch
- Release creation

**Features:**
- ✅ Build matrix for both boards
- ✅ Zephyr SDK installation
- ✅ West workspace setup
- ✅ Firmware compilation
- ✅ Artifact upload
- ✅ Build verification

**Build Matrix:**
```yaml
strategy:
  matrix:
    include:
      - board: noru64_split_center
        name: Center
        description: "Left side (Center) - USB connected"
      - board: noru64_split_peripheral  
        name: Peripheral
        description: "Right side (Peripheral) - BLE connected"
```

### Release Workflow (release.yml)

**Triggers:**
- When a release is published

**Features:**
- ✅ Download all artifacts
- ✅ Create release assets
- ✅ Generate build summary
- ✅ Upload release files

## 🔧 Manual Build

### Trigger Manual Build

1. Vào tab "Actions" trong GitHub
2. Chọn "ZMK Firmware Build"
3. Click "Run workflow"
4. Chọn options:
   - **Board**: all, noru64_split_center, noru64_split_peripheral
   - **Build type**: debug, release
5. Click "Run workflow"

### Build Parameters

- **board**: Chọn board cần build
- **build_type**: Chọn loại build (debug/release)

## 📦 Artifacts

### Download Artifacts

1. Vào tab "Actions"
2. Chọn workflow run
3. Scroll xuống phần "Artifacts"
4. Click download cho artifact cần thiết

### Artifact Contents

- **firmware-{board}-{commit}.uf2**: Firmware file
- **build-info.md**: Build information
- **build-logs-{board}-{commit}**: Build logs (nếu có lỗi)

## 🐛 Troubleshooting

### Common Issues

#### Build Fails
1. **Check logs**: Vào tab "Actions" → chọn failed run → xem logs
2. **Common causes**:
   - Syntax errors in .dts files
   - Missing dependencies
   - West workspace issues

#### Missing Artifacts
1. **Check build status**: Đảm bảo build thành công
2. **Check permissions**: Đảm bảo có quyền download artifacts
3. **Check retention**: Artifacts có thể bị xóa sau 30 ngày

#### Permission Errors
1. **Check repository settings**: Đảm bảo Actions được enable
2. **Check branch protection**: Đảm bảo có quyền push
3. **Check secrets**: Đảm bảo secrets được cấu hình đúng

### Debug Steps

1. **Check workflow syntax**: Validate YAML syntax
2. **Check dependencies**: Đảm bảo tất cả dependencies có sẵn
3. **Check environment**: Đảm bảo environment variables đúng
4. **Check logs**: Xem chi tiết logs để tìm lỗi

## 🔄 Customization

### Modify Build Matrix

Chỉnh sửa file `.github/workflows/zmk-build.yml`:

```yaml
strategy:
  matrix:
    include:
      - board: your_board
        name: Your Board
        description: "Your description"
```

### Add New Boards

1. Thêm board vào `build.yaml`
2. Tạo board configuration files
3. Cập nhật workflow matrix
4. Test build

### Modify Build Steps

Chỉnh sửa workflow steps trong `.github/workflows/zmk-build.yml`:

```yaml
steps:
  - name: Your Custom Step
    run: |
      your-command
```

## 📊 Monitoring

### Build Status

- **Green checkmark**: Build thành công
- **Red X**: Build thất bại
- **Yellow circle**: Build đang chạy
- **Gray circle**: Build bị cancel

### Notifications

- **Email**: GitHub sẽ gửi email khi build hoàn thành
- **Webhook**: Có thể cấu hình webhook cho notifications
- **Slack/Discord**: Có thể tích hợp với chat platforms

## 🔐 Security

### Secrets

Có thể thêm secrets cho:
- API keys
- Build tokens
- Deployment credentials

### Permissions

- **Read**: Có thể xem workflows và artifacts
- **Write**: Có thể trigger workflows
- **Admin**: Có thể modify workflows và settings

## 📚 Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [ZMK Documentation](https://zmk.dev/docs)
- [Zephyr RTOS Documentation](https://docs.zephyrproject.org/)
- [West Tool Documentation](https://docs.zephyrproject.org/latest/develop/west/index.html)
