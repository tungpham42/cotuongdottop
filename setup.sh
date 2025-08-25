#!/bin/bash

# Cờ Tướng DotTop - Khởi tạo dự án Laravel
echo "🎯 Cờ Tướng DotTop - Laravel Project Setup"
echo "========================================"

# Kiểm tra yêu cầu hệ thống
echo "📋 Kiểm tra yêu cầu hệ thống..."

# Kiểm tra PHP
if ! command -v php &> /dev/null; then
    echo "❌ PHP chưa được cài đặt. Vui lòng cài đặt PHP >= 8.0 (tối đa 8.2 cho Laravel 9)"
    exit 1
fi

php_version=$(php -r "echo PHP_VERSION;")
php_major=$(php -r "echo PHP_MAJOR_VERSION;")
php_minor=$(php -r "echo PHP_MINOR_VERSION;")

echo "✅ PHP: $php_version"

# Kiểm tra phiên bản PHP phù hợp với Laravel 9
if [ "$php_major" -lt 8 ]; then
    echo "❌ PHP phiên bản quá thấp. Laravel 9 yêu cầu PHP >= 8.0"
    exit 1
elif [ "$php_major" -eq 8 ] && [ "$php_minor" -gt 2 ]; then
    echo "⚠️ CẢNH BÁO: PHP $php_version có thể không tương thích với Laravel 9.x"
    echo "   Khuyến nghị downgrade về PHP 8.2:"
    echo "   brew install php@8.2"
    echo "   Kiểm tra version: php --version"
    echo "   Nếu vẫn hiển thị PHP $php_version, chạy: brew link --force --overwrite php@8.2"
elif [ "$php_major" -gt 8 ]; then
    echo "⚠️ CẢNH BÁO: PHP $php_version có thể không tương thích với Laravel 9.x"
    echo "   Khuyến nghị downgrade về PHP 8.2:"
    echo "   brew install php@8.2"
    echo "   Kiểm tra version: php --version"
    echo "   Nếu vẫn hiển thị PHP $php_version, chạy: brew link --force --overwrite php@8.2"
fi

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
echo "🗄️ KIỂM TRA VÀ THIẾT LẬP DATABASE"
echo "================================="

# Kiểm tra database đã tồn tại chưa
echo "🔍 Kiểm tra database cotuongdottop_db..."

# Hỏi thông tin MySQL root để kiểm tra
echo "📋 Cần thông tin MySQL để kiểm tra database:"
read -p "MySQL root username (mặc định: root): " mysql_root_user
mysql_root_user=${mysql_root_user:-root}

echo -n "MySQL root password (để trống nếu không có): "
read -s mysql_root_pass
echo ""

# Tạo command MySQL dựa trên có password hay không
if [ -z "$mysql_root_pass" ]; then
    mysql_cmd="mysql -u $mysql_root_user"
else
    mysql_cmd="mysql -u $mysql_root_user -p$mysql_root_pass"
fi

# Test MySQL connection trước
echo "🔍 Kiểm tra kết nối MySQL với credentials đã nhập..."
$mysql_cmd -e "SELECT 1;" > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "❌ Không thể kết nối MySQL với credentials đã nhập"
    echo "Vui lòng kiểm tra username/password và thử lại"
    exit 1
fi
echo "✅ MySQL connection: OK"

# Kiểm tra database existence
db_exists=$($mysql_cmd -e "SHOW DATABASES LIKE 'cotuongdottop_db';" 2>/dev/null | grep cotuongdottop_db)

if [ -z "$db_exists" ]; then
    echo "⚠️ Database chưa tồn tại"
    echo "🔧 Tự động tạo database và user..."
    
    # Thử tạo database (sử dụng credentials đã nhập)
    echo "🔧 Đang tạo database..."
    $mysql_cmd -e "
        CREATE DATABASE IF NOT EXISTS cotuongdottop_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
        CREATE USER IF NOT EXISTS 'cotuongdottop_user'@'localhost' IDENTIFIED BY 'CoTuongDotTop@123';
        GRANT ALL PRIVILEGES ON cotuongdottop_db.* TO 'cotuongdottop_user'@'localhost';
        FLUSH PRIVILEGES;
    " 2>/dev/null
    
    if [ $? -eq 0 ]; then
        echo "✅ Database và user đã được tạo tự động!"
    else
        echo "❌ Không thể tạo database tự động"
        echo "Vui lòng chạy manual:"
        echo "   mysql -u $mysql_root_user -p"
        echo "   CREATE DATABASE cotuongdottop_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
        echo "   CREATE USER 'cotuongdottop_user'@'localhost' IDENTIFIED BY 'CoTuongDotTop@123';"
        echo "   GRANT ALL PRIVILEGES ON cotuongdottop_db.* TO 'cotuongdottop_user'@'localhost';"
        echo "   FLUSH PRIVILEGES;"
        echo "   EXIT;"
        echo ""
        read -p "Nhấn Enter sau khi đã tạo database manual..." -r
    fi
else
    echo "✅ Database cotuongdottop_db đã tồn tại"
fi

# Test connection
echo "🔍 Kiểm tra kết nối database..."
mysql -u cotuongdottop_user -pCoTuongDotTop@123 cotuongdottop_db -e "SELECT 1;" > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "❌ Không thể kết nối database với user cotuongdottop_user"
    echo "Vui lòng kiểm tra:"
    echo "   - MySQL service: brew services list | grep mysql"
    echo "   - User permissions: mysql -u root -p -e \"SHOW GRANTS FOR 'cotuongdottop_user'@'localhost';\""
    exit 1
fi
echo "✅ Database connection: OK"

# Cập nhật .env file tự động
echo "📝 Cập nhật file .env với database config..."
if [ -f .env ]; then
    # Update existing .env
    sed -i '' 's/^DB_DATABASE=.*/DB_DATABASE=cotuongdottop_db/' .env
    sed -i '' 's/^DB_USERNAME=.*/DB_USERNAME=cotuongdottop_user/' .env
    sed -i '' 's/^DB_PASSWORD=.*/DB_PASSWORD=CoTuongDotTop@123/' .env
    echo "✅ File .env đã được cập nhật"
fi

# Clear cache trước khi migrate
echo "🧹 Clear cache và autoload..."
php artisan cache:clear > /dev/null 2>&1
php artisan config:clear > /dev/null 2>&1
composer dump-autoload > /dev/null 2>&1

# Dọn dẹp migration files lỗi
echo "🧹 Dọn dẹp migration files..."
# Xóa các file migration trống hoặc duplicate
find database/migrations/ -name "*.php" -size 0 -delete 2>/dev/null
# Xóa migration simple duplicate nếu có
rm -f database/migrations/*_create_rooms_table_simple.php 2>/dev/null

# Chạy migration với error handling
echo "🔄 Chạy database migrations..."
php artisan migrate --force
if [ $? -ne 0 ]; then
    echo "❌ Migration failed. Thử reset và chạy lại..."
    php artisan migrate:reset --force > /dev/null 2>&1
    php artisan migrate --force
    if [ $? -ne 0 ]; then
        echo "❌ Migration vẫn failed. Chạy script fix-migrations.sh để khắc phục."
        echo "   ./fix-migrations.sh"
        exit 1
    fi
fi

# Kiểm tra và chạy seeding
echo "🌱 Kiểm tra dữ liệu database..."

# Kiểm tra xem có dữ liệu trong các bảng chính chưa (users, rooms, players)
users_count=$(mysql -u cotuongdottop_user -pCoTuongDotTop@123 cotuongdottop_db -se "SELECT COUNT(*) FROM users;" 2>/dev/null || echo "0")
rooms_count=$(mysql -u cotuongdottop_user -pCoTuongDotTop@123 cotuongdottop_db -se "SELECT COUNT(*) FROM rooms;" 2>/dev/null || echo "0")
players_count=$(mysql -u cotuongdottop_user -pCoTuongDotTop@123 cotuongdottop_db -se "SELECT COUNT(*) FROM players;" 2>/dev/null || echo "0")

total_records=$((users_count + rooms_count + players_count))

if [ "$total_records" -gt 0 ]; then
    echo "✅ Database đã có dữ liệu (users: $users_count, rooms: $rooms_count, players: $players_count), bỏ qua seeding"
else
    echo "🌱 Database trống, đang seed dữ liệu mẫu..."
    php artisan db:seed --force
    if [ $? -eq 0 ]; then
        echo "✅ Seed dữ liệu thành công!"
    else
        echo "⚠️ Seed failed nhưng không ảnh hưởng đến hoạt động"
    fi
fi

echo ""
echo "✅ KHỞI TẠO THÀNH CÔNG!"
echo "======================"
echo "🎮 Dự án đã sẵn sàng!"
echo ""
echo "🚀 Để chạy server development:"
echo "   php artisan serve"
echo "   Hoặc chỉ định port: php artisan serve --port=8888"
echo ""
echo "🌐 Truy cập: http://localhost:8000 (hoặc port tương ứng)"
echo ""
echo "📱 Thông tin database:"
echo "   Database: cotuongdottop_db"
echo "   Username: cotuongdottop_user"
echo "   Password: CoTuongDotTop@123"
echo ""
echo "💡 Lưu ý: Nếu port 8000 bị chiếm, hãy thử port khác như 8001, 8080, 8888"
