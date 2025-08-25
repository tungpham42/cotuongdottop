#!/bin/bash

# Cờ Tướng DotTop - Migration Fix Script
echo "🔧 Cờ Tướng DotTop - Migration Fix"
echo "=================================="

echo "🔍 Chẩn đoán vấn đề..."

# Kiểm tra database connection
echo "📡 Testing database connection..."
mysql -u cotuongdottop_user -pCoTuongDotTop@123 cotuongdottop_db -e "SELECT 1;" > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "❌ Database connection failed!"
    echo "   Vui lòng kiểm tra:"
    echo "   1. MySQL service: brew services list | grep mysql"
    echo "   2. Database exists: mysql -u root -p -e 'SHOW DATABASES;'"
    echo "   3. User permissions: mysql -u root -p -e 'SHOW GRANTS FOR cotuongdottop_user@localhost;'"
    exit 1
fi
echo "✅ Database connection: OK"

# Kiểm tra migrations table
echo "📋 Checking migrations table..."
migration_table_exists=$(mysql -u cotuongdottop_user -pCoTuongDotTop@123 cotuongdottop_db -se "SHOW TABLES LIKE 'migrations';" 2>/dev/null)
if [ -z "$migration_table_exists" ]; then
    echo "⚠️ Migrations table không tồn tại"
else
    echo "✅ Migrations table: OK"
fi

# Kiểm tra bảng rooms
echo "🏠 Checking rooms table..."
rooms_table_exists=$(mysql -u cotuongdottop_user -pCoTuongDotTop@123 cotuongdottop_db -se "SHOW TABLES LIKE 'rooms';" 2>/dev/null)
if [ -z "$rooms_table_exists" ]; then
    echo "⚠️ Rooms table không tồn tại"
else
    echo "✅ Rooms table: OK"
fi

echo ""
echo "🛠️ BẮTT ĐẦU SỬA LỖI"
echo "=================="

# Backup migrations có vấn đề
echo "💾 Backup problematic migrations..."
mkdir -p /tmp/backup_migrations
if [ -f "database/migrations/2015_07_22_181406_update_forum_table_categories.php" ]; then
    cp database/migrations/2015_07_22_181406_update_forum_table_categories.php /tmp/backup_migrations/
fi

# Clear tất cả cache
echo "🧹 Clearing all caches..."
php artisan cache:clear > /dev/null 2>&1
php artisan config:clear > /dev/null 2>&1
php artisan route:clear > /dev/null 2>&1
php artisan view:clear > /dev/null 2>&1
composer dump-autoload > /dev/null 2>&1

# Reset migrations
echo "🔄 Resetting migrations..."
php artisan migrate:reset --force > /dev/null 2>&1

# Tạm thời move problematic migrations
echo "📦 Temporarily moving problematic migrations..."
mkdir -p /tmp/problematic_migrations
find database/migrations/ -name "*forum*" -name "*update*" -exec mv {} /tmp/problematic_migrations/ \; 2>/dev/null

# Chạy core migrations trước
echo "🏗️ Running core migrations..."
php artisan migrate --force

# Khôi phục problematic migrations
echo "📦 Restoring problematic migrations..."
if [ -d "/tmp/problematic_migrations" ]; then
    mv /tmp/problematic_migrations/* database/migrations/ 2>/dev/null
fi

# Dump autoload lại
composer dump-autoload > /dev/null 2>&1

# Chạy remaining migrations
echo "🔄 Running remaining migrations..."
php artisan migrate --force

# Seed data
echo "🌱 Seeding sample data..."
php artisan db:seed --force

echo ""
echo "✅ FIX HOÀN TẤT!"
echo "================="
echo "🎮 Kiểm tra kết quả:"
echo "   php artisan migrate:status"
echo "   mysql -u cotuongdottop_user -pCoTuongDotTop@123 cotuongdottop_db -e 'SHOW TABLES;'"
echo ""
echo "🚀 Nếu OK, chạy server:"
echo "   php artisan serve"
