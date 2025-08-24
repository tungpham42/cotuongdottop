#!/bin/bash

# Cờ Tướng DotTop - Khởi tạo dự án Laravel
echo "🎯 Cờ Tướng DotTop - Laravel Project Setup"
echo "========================================"

# Kiểm tra yêu cầu hệ thống
echo "📋 Kiểm tra yêu cầu hệ thống..."

# Kiểm tra PHP
if ! command -v php &> /dev/null; then
    echo "❌ PHP chưa được cài đặt. Vui lòng cài đặt PHP >= 8.0"
    exit 1
fi

php_version=$(php -r "echo PHP_VERSION;")
echo "✅ PHP: $php_version"

# Kiểm tra Composer
if ! command -v composer &> /dev/null; then
    echo "❌ Composer chưa được cài đặt. Vui lòng cài đặt Composer"
    exit 1
fi

composer_version=$(composer --version)
echo "✅ $composer_version"

# Kiểm tra MySQL
if ! command -v mysql &> /dev/null; then
    echo "❌ MySQL chưa được cài đặt. Vui lòng cài đặt MySQL"
    exit 1
fi

echo "✅ MySQL đã được cài đặt"

# Kiểm tra Node.js
if ! command -v node &> /dev/null; then
    echo "❌ Node.js chưa được cài đặt. Vui lòng cài đặt Node.js"
    exit 1
fi

node_version=$(node --version)
echo "✅ Node.js: $node_version"

# Kiểm tra npm
if ! command -v npm &> /dev/null; then
    echo "❌ npm chưa được cài đặt. Vui lòng cài đặt npm"
    exit 1
fi

npm_version=$(npm --version)
echo "✅ npm: $npm_version"

echo ""
echo "🚀 Bắt đầu khởi tạo dự án..."

# Cài đặt dependencies
echo "📦 Cài đặt dependencies..."
composer install --no-interaction --prefer-dist --optimize-autoloader
npm install

# Kiểm tra file .env
if [ ! -f .env ]; then
    echo "📝 Tạo file .env từ .env.example..."
    cp .env.example .env
fi

# Tạo app key
echo "🔑 Tạo application key..."
php artisan key:generate

# Hướng dẫn cấu hình database
echo ""
echo "🗄️ HƯỚNG DẪN CẤU HÌNH DATABASE"
echo "================================"
echo "1. Tạo database MySQL:"
echo "   mysql -u root -p"
echo "   CREATE DATABASE cotuongdottop_db;"
echo "   CREATE USER 'cotuongdottop_user'@'localhost' IDENTIFIED BY 'CoTuongDotTop@123';"
echo "   GRANT ALL PRIVILEGES ON cotuongdottop_db.* TO 'cotuongdottop_user'@'localhost';"
echo "   FLUSH PRIVILEGES;"
echo "   EXIT;"
echo ""
echo "2. Cập nhật file .env với thông tin database:"
echo "   DB_DATABASE=cotuongdottop_db"
echo "   DB_USERNAME=cotuongdottop_user"
echo "   DB_PASSWORD=CoTuongDotTop@123"
echo ""

# Hỏi người dùng có muốn chạy migration không
read -p "Bạn đã cấu hình database chưa? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Chạy migration
    echo "🔄 Chạy database migrations..."
    php artisan migrate --force
    
    # Chạy seeding
    echo "🌱 Seed dữ liệu mẫu..."
    php artisan db:seed --force
    
    echo ""
    echo "✅ KHỞI TẠO THÀNH CÔNG!"
    echo "======================"
    echo "🎮 Dự án đã sẵn sàng!"
    echo ""
    echo "🚀 Để chạy server development:"
    echo "   php artisan serve"
    echo ""
    echo "🌐 Truy cập: http://localhost:8000"
    echo ""
    echo "📱 Thông tin database:"
    echo "   Database: cotuongdottop_db"
    echo "   Username: cotuongdottop_user"
    echo "   Password: CoTuongDotTop@123"
    echo ""
else
    echo ""
    echo "⚠️ Vui lòng cấu hình database trước, sau đó chạy:"
    echo "   php artisan migrate"
    echo "   php artisan db:seed"
    echo "   php artisan serve"
fi
