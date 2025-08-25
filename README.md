# 🎯 Cờ Tướng DotTop - Online Chinese Chess Game

🎮 **Cờ Tướng Online** - Game cờ tướng trực tuyến được xây dựng bằng Laravel với JavaScript, tính năng realtime, chat, bài tập cờ và forum thảo luận.

## 🚀 Khởi tạo dự án "1 phát ăn luôn"

### 📋 Yêu cầu hệ thống
- **PHP 8.0 - 8.2** (⚠️ PHP 8.3+ chưa được hỗ trợ đầy đủ với Laravel 9.x)
- **Composer 2.x**
- **MySQL 5.7+ / MariaDB 10.3+**
- **Node.js & npm**

**⚠️ Lưu ý quan trọng về PHP version:**
- Laravel 9.x chỉ tương thích tốt với PHP 8.0-8.2
- Nếu đang dùng PHP 8.3+, khuyến nghị downgrade về PHP 8.2

### 🔧 Cài đặt tự động (Khuyến nghị) ⭐

**Chỉ cần 4 lệnh:**
```bash
git clone <repository-url>
cd cotuongdottop
chmod +x setup.sh
./setup.sh
```

**Khi chạy script sẽ hỏi:**
- MySQL root username (thường là `root`)
- MySQL root password (nhập password MySQL của bạn)

**Script sẽ tự động:**
- ✅ Kiểm tra yêu cầu hệ thống (PHP, Composer, MySQL, Node.js)
- 📦 Cài đặt dependencies (composer install + npm install)
- 🔑 Tạo file .env và generate app key
- 🗄️ **Tự động tạo database và user** (không cần tạo thủ công!)
- 🔄 Chạy migration tạo bảng
- 🌱 **Kiểm tra thông minh:** chỉ seed data khi database trống
- � Sẵn sàng chạy `php artisan serve`

**Nếu gặp lỗi migration:**
```bash
chmod +x fix-migrations.sh
./fix-migrations.sh
```

### 🎮 Chạy dự án
```bash
# Sau khi setup xong, chạy server
php artisan serve

# Hoặc chỉ định port nếu 8000 bị chiếm
php artisan serve --port=8888
```

🎉 **Truy cập:** http://localhost:8000 để chơi cờ tướng!

## � Cấu trúc Database

**Database được tạo tự động:** `cotuongdottop_db`

### Bảng chính:
- **users** - Thông tin người dùng (name, email, elo, points, last_seen_at)
- **rooms** - Quản lý phòng chơi cờ (code, name, player_turn, fen, scores)
- **players** - Thông tin người chơi
- **puzzles** - Cờ thế và puzzle
- **contacts** - Liên hệ từ người dùng
- **ch_messages** - Tin nhắn chat (Chatify package)
- **ch_favorites** - Danh sách yêu thích
- **personal_access_tokens** - API tokens (Laravel Sanctum)
- **migrations** - Theo dõi migration status

## � Troubleshooting

### 🚨 Quick Fix cho lỗi thường gặp

**Nếu setup.sh bị lỗi migration hoặc database:**
```bash
# Chạy script fix tự động
./fix-migrations.sh
```

**Hoặc fix manual nhanh:**
```bash
# Reset và chạy lại migration
php artisan migrate:reset --force
composer dump-autoload
php artisan migrate --force
php artisan db:seed --force
```

**Script setup.sh failed giữa chừng:**
```bash
# Xóa database và chạy lại từ đầu
mysql -u root -p -e "DROP DATABASE IF EXISTS cotuongdottop_db; DROP USER IF EXISTS 'cotuongdottop_user'@'localhost';"
./setup.sh
```

### 🔄 Thông tin Database tự động
Script setup.sh sẽ tự động tạo:
- **Database:** `cotuongdottop_db`
- **Username:** `cotuongdottop_user` 
- **Password:** `CoTuongDotTop@123`
- **Character Set:** `utf8mb4`
- **Collation:** `utf8mb4_unicode_ci`

### 🎯 Tính năng thông minh của script
- **Kiểm tra dữ liệu:** Script chỉ seed khi database trống
- **Error handling:** Tự động retry migration nếu failed
- **Dọn dẹp migration:** Xóa file migration lỗi/duplicate
- **Validation:** Kiểm tra MySQL credentials trước khi thao tác

## 🔧 Cài đặt thủ công (Chỉ khi script tự động failed)

**⚠️ Khuyến nghị sử dụng script `setup.sh` tự động bên trên!**

<details>
<summary>📖 Click để xem hướng dẫn manual setup</summary>

### Bước 1: Clone và cài đặt dependencies
```bash
git clone <repository_url>
cd cotuongdottop
composer install --no-interaction --prefer-dist --optimize-autoloader
npm install
```

### Bước 2: Tạo file .env
```bash
cp .env.example .env
php artisan key:generate
```

### Bước 3: Cấu hình database trong .env
```env
DB_CONNECTION=mysql
DB_HOST=localhost
DB_PORT=3306
DB_DATABASE=cotuongdottop_db
DB_USERNAME=cotuongdottop_user
DB_PASSWORD=CoTuongDotTop@123
```

### Bước 4: Tạo database và user MySQL
```bash
# Đăng nhập MySQL với user root
mysql -u root -p

# Tạo database và user (chạy trong MySQL)
CREATE DATABASE cotuongdottop_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'cotuongdottop_user'@'localhost' IDENTIFIED BY 'CoTuongDotTop@123';
GRANT ALL PRIVILEGES ON cotuongdottop_db.* TO 'cotuongdottop_user'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

### Bước 5: Chạy migration và seed dữ liệu
```bash
php artisan migrate --force
php artisan db:seed --force
```

### Bước 6: Khởi động server
```bash
php artisan serve
```

🎉 **Hoàn thành!** Truy cập http://localhost:8000

</details>

## 🎮 Tính năng chính

- ♟️ **Chơi cờ tướng online real-time** - Engine JavaScript với HTML5 Canvas
- � **Multiplayer** - Đối chiến với người chơi khác
- 🧩 **Hệ thống puzzle và cờ thế** - Luyện tập và nâng cao kỹ năng
- 💬 **Chat trực tuyến** - Trao đổi trong game (Chatify package)
- 📊 **Thống kê và ELO rating** - Xếp hạng người chơi
- 🎯 **Hệ thống phòng** - Tạo phòng riêng hoặc vào phòng sẵn có
- 🌍 **Đa ngôn ngữ** - Hỗ trợ VI, EN, JA, KO, ZH

## �🛠️ Tech Stack

- **Backend**: Laravel 9.x (PHP 8.0-8.2)
- **Frontend**: JavaScript, HTML5 Canvas cho board cờ
- **Database**: MySQL 5.7+ / MariaDB 10.3+
- **Real-time**: WebSocket/Pusher cho game real-time
- **Chat**: Chatify package
- **Build Tools**: Laravel Mix, Webpack
- **Package Managers**: Composer 2.x, NPM

## � Troubleshooting

### Lỗi PHP version không tương thích

**Nếu bạn gặp lỗi với PHP 8.3+ trên macOS:**
```bash
# Bước 1: Cài đặt PHP 8.2
brew install php@8.2

# Bước 2: Kiểm tra version hiện tại
php --version

# Bước 3: Nếu vẫn hiển thị PHP 8.3+, mới cần link
brew link --force --overwrite php@8.2

# Bước 4: Hoặc sử dụng PATH (không thay đổi system PHP)
echo 'export PATH="/opt/homebrew/opt/php@8.2/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

# Bước 5: Xác nhận version đã đúng
php --version    # Phải hiển thị PHP 8.2.x
```

**Trên Ubuntu/Debian:**
```bash
# Thêm repository PHP
sudo add-apt-repository ppa:ondrej/php
sudo apt update

# Cài đặt PHP 8.2
sudo apt install php8.2 php8.2-cli php8.2-common

# Switch version
sudo update-alternatives --config php
```

### Lỗi dependencies và cache
```bash
# Clear cache Laravel
php artisan cache:clear
php artisan config:clear
php artisan route:clear

# Reinstall dependencies
rm -rf vendor/ node_modules/
composer install
npm install
```

### Lỗi database connection
```bash
# Kiểm tra MySQL service
sudo systemctl status mysql    # Linux
brew services list | grep mysql    # macOS

# Test connection
mysql -u cotuongdottop_user -p cotuongdottop_db
```

### Lỗi migration và bảng không tồn tại

**Lỗi: `Table 'rooms' doesn't exist` hoặc `Class not found`**
```bash
# Bước 1: Reset migrations hoàn toàn
php artisan migrate:reset

# Bước 2: Clear tất cả cache
php artisan cache:clear
php artisan config:clear
php artisan route:clear
composer dump-autoload

# Bước 3: Chạy lại migrations
php artisan migrate --force

# Bước 4: Nếu vẫn lỗi, kiểm tra database
mysql -u cotuongdottop_user -pCoTuongDotTop@123 cotuongdottop_db -e "SHOW TABLES;"

# Bước 5: Nếu database trống, seed lại
php artisan db:seed --force
```

**Lỗi: `UpdateForumTableCategories not found`**
```bash
# Xóa migration bị lỗi tạm thời
mv database/migrations/2015_07_22_181406_update_forum_table_categories.php /tmp/

# Chạy migration
php artisan migrate

# Khôi phục file migration
mv /tmp/2015_07_22_181406_update_forum_table_categories.php database/migrations/
```

---

## 📞 Hỗ trợ và Debug

### 🆘 Nếu gặp lỗi không giải quyết được:

1. **Chạy script fix tự động:**
   ```bash
   ./fix-migrations.sh
   ```

2. **Reset hoàn toàn và chạy lại:**
   ```bash
   # Xóa database và chạy lại từ đầu
   mysql -u root -p -e "DROP DATABASE IF EXISTS cotuongdottop_db; DROP USER IF EXISTS 'cotuongdottop_user'@'localhost';"
   rm -rf vendor node_modules
   ./setup.sh
   ```

3. **Kiểm tra system requirements:**
   ```bash
   php --version        # Phải 8.0-8.2
   composer --version   # Phải 2.x
   mysql --version      # Phải 5.7+
   ```

### 🐛 Debug commands hữu ích

```bash
# Kiểm tra trạng thái migration
php artisan migrate:status

# Xem bảng trong database  
mysql -u cotuongdottop_user -pCoTuongDotTop@123 cotuongdottop_db -e "SHOW TABLES;"

# Kiểm tra cấu trúc bảng
mysql -u cotuongdottop_user -pCoTuongDotTop@123 cotuongdottop_db -e "DESCRIBE users;"

# Check Laravel config
php artisan config:show database
```

### ✅ Script được test thành công trên:

- **macOS Monterey+** với Homebrew MySQL
- **PHP 8.2.x** + Composer 2.x + MySQL 8.0
- **Database tự động tạo** và migration thành công
- **Seeding thông minh** (chỉ seed khi database trống)

### 🎯 Tóm tắt quy trình hoàn hảo:

```bash
# Bước 1: Clone project
git clone <repository-url>
cd cotuongdottop

# Bước 2: Chạy script tự động  
chmod +x setup.sh
./setup.sh
# (Nhập MySQL root credentials khi được hỏi)

# Bước 3: Chạy server
php artisan serve --port=8888

# Bước 4: Vào http://localhost:8888 chơi cờ! 🎮
```

**🎉 Chúc bạn setup thành công và có những ván cờ hay! ♟️**
