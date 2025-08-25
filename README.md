# 🎯 Cờ Tướng DotTop - Online Chinese Chess Game

🎮 **Cờ Tướng Online** - Game cờ tướng trực tuyến được xây dựng bằng Laravel v## 🐛 Troubleshooting

### 🚨 Quick Fix cho lỗi thường gặp

**Nếu setup.sh bị lỗi migration hoặc database:**
```bash
# Chạy script fix tự động
./fix-migrations.sh
```

**Hoặc fix manual nhanh:**
```bash
# Reset và chạy lại
php artisan migrate:reset --force
composer dump-autoload
php artisan migrate --force
php artisan db:seed --force
```

### Lỗi PHP version không tương thíchavaScript với tính năng realtime, chat, bài tập cờ và forum thảo luận.

## 🚀 Khởi tạo dự án "1 phát ăn luôn"

### 📋 Yêu cầu hệ thống
- PHP >= 8.0 (tối đa PHP 8.2 cho Laravel 9.x)
- Composer
- MySQL/MariaDB
- Node.js & npm

**⚠️ Lưu ý về PHP version:**
- Nếu bạn đang dùng PHP > 8.2, khuyến nghị downgrade về PHP 8.2:
  ```bash
  # macOS với Homebrew
  brew install php@8.2
  brew link --force --overwrite php@8.2
  
  # Hoặc thêm vào .zshrc/.bashrc
  export PATH="/opt/homebrew/opt/php@8.2/bin:$PATH"
  ```

### 🔧 Cài đặt tự động (Khuyến nghị)

**Sử dụng script setup tự động:**
```bash
git clone <repository-url>
cd cotuongdottop
chmod +x setup.sh
./setup.sh
```

**Nếu gặp lỗi migration, chạy script fix:**
```bash
chmod +x fix-migrations.sh
./fix-migrations.sh
```

Script sẽ tự động:
- ✅ Kiểm tra yêu cầu hệ thống
- 📦 Cài đặt dependencies (composer + npm)
- 🔑 Tạo file .env và generate app key
- 🗄️ Hướng dẫn cấu hình database
- 🔄 Chạy migration và seed dữ liệu

### 🔧 Cài đặt thủ công

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

### Bước 6: Compile assets và khởi động server
```bash
npm run dev
php artisan serve
```

🎉 **Hoàn thành!** Truy cập http://127.0.0.1:8000 để chơi cờ tướng online!

## 📁 Cấu trúc Database

- **rooms** - Quản lý phòng chơi cờ
- **users** - Thông tin người dùng 
- **players** - Thông tin người chơi
- **puzzles** - Cờ thế và puzzle
- **posts** - Bài viết và nội dung
- **contacts** - Liên hệ từ người dùng
- **ch_messages** - Tin nhắn chat
- **ch_favorites** - Danh sách yêu thích

## 🎮 Tính năng chính

- ♟️ Chơi cờ tướng online real-time
- 👥 Multiplayer với người chơi khác
- 🧩 Hệ thống puzzle và cờ thế
- 💬 Chat trực tuyến
- 📊 Thống kê và ranking
- 🌍 Hỗ trợ đa ngôn ngữ (VI, EN, JA, KO, ZH)

## 🛠️ Tech Stack

- **Backend**: Laravel 9.x (requires PHP 8.0-8.2)
- **Frontend**: JavaScript, HTML5 Canvas
- **Database**: MySQL 5.7+ / MariaDB 10.3+
- **Chat**: Chatify package
- **Assets**: Laravel Mix
- **Package Manager**: Composer 2.x, NPM

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

## �📝 License

The Laravel framework is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).

Laravel is accessible, powerful, and provides tools required for large, robust applications.

## Learning Laravel

Laravel has the most extensive and thorough [documentation](https://laravel.com/docs) and video tutorial library of all modern web application frameworks, making it a breeze to get started with the framework.

If you don't feel like reading, [Laracasts](https://laracasts.com) can help. Laracasts contains over 1500 video tutorials on a range of topics including Laravel, modern PHP, unit testing, and JavaScript. Boost your skills by digging into our comprehensive video library.

## Laravel Sponsors

We would like to extend our thanks to the following sponsors for funding Laravel development. If you are interested in becoming a sponsor, please visit the Laravel [Patreon page](https://patreon.com/taylorotwell).

### Premium Partners

- **[Vehikl](https://vehikl.com/)**
- **[Tighten Co.](https://tighten.co)**
- **[Kirschbaum Development Group](https://kirschbaumdevelopment.com)**
- **[64 Robots](https://64robots.com)**
- **[Cubet Techno Labs](https://cubettech.com)**
- **[Cyber-Duck](https://cyber-duck.co.uk)**
- **[Many](https://www.many.co.uk)**
- **[Webdock, Fast VPS Hosting](https://www.webdock.io/en)**
- **[DevSquad](https://devsquad.com)**
- **[OP.GG](https://op.gg)**

## Contributing

Thank you for considering contributing to the Laravel framework! The contribution guide can be found in the [Laravel documentation](https://laravel.com/docs/contributions).

## Code of Conduct

In order to ensure that the Laravel community is welcoming to all, please review and abide by the [Code of Conduct](https://laravel.com/docs/contributions#code-of-conduct).

## Security Vulnerabilities

If you discover a security vulnerability within Laravel, please send an e-mail to Taylor Otwell via [taylor@laravel.com](mailto:taylor@laravel.com). All security vulnerabilities will be promptly addressed.

## License

The Laravel framework is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).
