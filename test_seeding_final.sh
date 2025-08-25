#!/bin/bash

echo "🌱 Kiểm tra dữ liệu database..."

# Kiểm tra xem có dữ liệu trong các bảng chính chưa (users, rooms, players)
users_count=$(mysql -u cotuongdottop_user -pCoTuongDotTop@123 cotuongdottop_db -se "SELECT COUNT(*) FROM users;" 2>/dev/null || echo "0")
rooms_count=$(mysql -u cotuongdottop_user -pCoTuongDotTop@123 cotuongdottop_db -se "SELECT COUNT(*) FROM rooms;" 2>/dev/null || echo "0")
players_count=$(mysql -u cotuongdottop_user -pCoTuongDotTop@123 cotuongdottop_db -se "SELECT COUNT(*) FROM players;" 2>/dev/null || echo "0")

total_records=$((users_count + rooms_count + players_count))

echo "Debug: users=$users_count, rooms=$rooms_count, players=$players_count, total=$total_records"

if [ "$total_records" -gt 0 ]; then
    echo "✅ Database đã có dữ liệu (users: $users_count, rooms: $rooms_count, players: $players_count), bỏ qua seeding"
else
    echo "🌱 Database trống, đang seed dữ liệu mẫu..."
    echo "php artisan db:seed --force"
fi
