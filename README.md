# 🎯 Cờ Tướng DotTop - Online Chinese Chess Game

🎮 **Cờ Tướng Online** - Game cờ tướng trực tuyến được xây dựng bằng Laravel và JavaScript với tính năng realtime, chat, bài tập cờ và forum thảo luận.

## 🚀 Khởi tạo dự án "1 phát ăn luôn"

### 📋 Yêu cầu hệ thống
- PHP >= 8.0
- Composer
- MySQL/MariaDB
- Node.js & npm

### 🔧 Cài đặt tự động (Khuyến nghị)

**Sử dụng script setup tự động:**
```bash
git clone <repository-url>
cd cotuongdottop
chmod +x setup.sh
./setup.sh
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

- **Backend**: Laravel 9.x
- **Frontend**: JavaScript, HTML5 Canvas
- **Database**: MySQL
- **Chat**: Chatify package
- **Assets**: Laravel Mix

## 📝 License

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
