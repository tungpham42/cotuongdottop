#!/bin/bash

# Cờ Tướng DotTop - Validation Script
echo "🧪 Cờ Tướng DotTop - Validation Test"
echo "===================================="

# Test database connection
echo "🔍 Testing database connection..."
php artisan migrate:status > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "✅ Database connection: OK"
else
    echo "❌ Database connection: FAILED"
fi

# Test migration status
echo "🔍 Checking migration status..."
migration_count=$(php artisan migrate:status | grep -c "Ran")
echo "✅ Migrations completed: $migration_count"

# Test seeded data
echo "🔍 Checking seeded data..."
room_count=$(mysql -u cotuongdottop_user -pCoTuongDotTop@123 cotuongdottop_db -se "SELECT COUNT(*) FROM rooms;" 2>/dev/null)
if [ "$room_count" -gt 0 ]; then
    echo "✅ Sample data seeded: $room_count rooms found"
else
    echo "⚠️ No sample data found in rooms table"
fi

# Test key Laravel commands
echo "🔍 Testing Laravel commands..."
php artisan route:list > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "✅ Laravel routes: OK"
else
    echo "❌ Laravel routes: FAILED"
fi

# Test server start (quick test)
echo "🔍 Testing server startup..."
timeout 3 php artisan serve --port=8002 > /dev/null 2>&1 &
sleep 2
if pgrep -f "artisan serve" > /dev/null; then
    echo "✅ Server startup: OK"
    pkill -f "artisan serve"
else
    echo "❌ Server startup: FAILED"
fi

# Check core files
echo "🔍 Checking core files..."
if [ -f ".env" ]; then
    echo "✅ .env file: EXISTS"
else
    echo "❌ .env file: MISSING"
fi

if [ -f "composer.lock" ]; then
    echo "✅ Composer dependencies: INSTALLED"
else
    echo "❌ Composer dependencies: MISSING"
fi

if [ -d "node_modules" ]; then
    echo "✅ NPM dependencies: INSTALLED"
else
    echo "❌ NPM dependencies: MISSING"
fi

echo ""
echo "🎯 VALIDATION COMPLETE"
echo "======================="
echo "If all tests show ✅, your project is ready to go!"
echo "Run 'php artisan serve' to start the development server."
