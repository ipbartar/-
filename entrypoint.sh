#!/bin/bash

set -e

echo "=========================================="
echo "شروع راه‌اندازی Mirza Pro در Railway"
echo "=========================================="

# متغیرهای محیط‌ایی (پیش‌فرض)
BOT_TOKEN="${BOT_TOKEN:-}"
ADMIN_ID="${ADMIN_ID:-}"
BOT_USERNAME="${BOT_USERNAME:-}"
DB_NAME="${DB_NAME:-mirzaprobot}"
DB_USER="${DB_USER:-root}"
DB_PASSWORD="${DB_PASSWORD:-mirzapro_secure_2024}"
BOT_DOMAIN="${BOT_DOMAIN:-localhost}"
WEBHOOK_URL="${WEBHOOK_URL:-}"

# تأخیر برای اطمینان از شروع صحیح سرویس‌ها
echo "⏳ تأخیر 5 ثانیه‌ای برای مقداردهی اولیه سیستم..."
sleep 5

echo ""
echo "--- شروع MySQL ---"
if ! pgrep -x "mysqld" > /dev/null; then
    echo "MySQL در حال شروع است..."
    mkdir -p /run/mysqld
    chown mysql:mysql /run/mysqld
    chmod 777 /run/mysqld
    
    # شروع MySQL در پس‌زمینه
    mysqld_safe --user=mysql --skip-grant-tables &
    
    # انتظار برای شروع MySQL
    sleep 10
    
    # اتصال و تنظیم دیتابیس
    echo "تنظیم دیتابیس..."
    mysql -u root -e "CREATE DATABASE IF NOT EXISTS \`$DB_NAME\` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;" 2>/dev/null || true
    mysql -u root -e "GRANT ALL PRIVILEGES ON \`$DB_NAME\`.* TO '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASSWORD';" 2>/dev/null || true
    mysql -u root -e "FLUSH PRIVILEGES;" 2>/dev/null || true
    
    echo "✅ MySQL آماده است"
else
    echo "✅ MySQL قبلاً درحال اجرا است"
fi

echo ""
echo "--- دانلود و نصب Mirza Pro ---"

BOT_DIR="/var/www/html/mirzaprobotconfig"
mkdir -p "$BOT_DIR"

# دانلود آخرین نسخه
if [ ! -f "$BOT_DIR/index.php" ]; then
    echo "دانلود Mirza Pro..."
    cd /tmp
    rm -rf mirza_pro-main 2>/dev/null || true
    
    # دانلود zip
    wget -q https://github.com/mahdiMGF2/mirza_pro/archive/refs/heads/main.zip -O mirza_pro.zip 2>/dev/null || curl -sL https://github.com/mahdiMGF2/mirza_pro/archive/refs/heads/main.zip -o mirza_pro.zip
    
    unzip -q mirza_pro.zip
    
    # کپی فایل‌ها
    cp -r mirza_pro-main/* "$BOT_DIR/" 2>/dev/null || echo "نسخه‌ای موجود است"
    
    rm -rf /tmp/mirza_pro.zip /tmp/mirza_pro-main 2>/dev/null || true
    
    echo "✅ Mirza Pro دانلود شد"
else
    echo "✅ Mirza Pro قبلاً نصب است"
fi

# تنظیم مجوزها
chown -R www-data:www-data "$BOT_DIR"
chmod -R 755 "$BOT_DIR"
chmod -R 777 "$BOT_DIR/uploads" 2>/dev/null || true
chmod -R 777 "$BOT_DIR/storage" 2>/dev/null || true
chmod -R 777 "$BOT_DIR/logs" 2>/dev/null || true

echo ""
echo "--- شناسایی دامنه عمومی Railway ---"

# تشخیص خودکار دامنه عمومی
if [ -z "$BOT_DOMAIN" ] || [ "$BOT_DOMAIN" = "localhost" ]; then
    # از متغیر Railway
    if [ -n "$RAILWAY_PUBLIC_DOMAIN" ]; then
        BOT_DOMAIN="$RAILWAY_PUBLIC_DOMAIN"
        echo "✅ دامنه Railway تشخیص داده شد: $BOT_DOMAIN"
    fi
fi

# اگر هنوز تنظیم نشده، از PORT استفاده کن
if [ -z "$BOT_DOMAIN" ] || [ "$BOT_DOMAIN" = "localhost" ]; then
    # برای Development/Testing
    BOT_DOMAIN="localhost:${PORT:-8080}"
    echo "⚠️  از دامنه محلی استفاده می‌شود: $BOT_DOMAIN"
fi

# Webhook URL را تکمیل کن
if [ -z "$WEBHOOK_URL" ]; then
    if [[ "$BOT_DOMAIN" == *"railway.app" ]]; then
        WEBHOOK_URL="https://$BOT_DOMAIN/webhook"
    else
        WEBHOOK_URL="http://$BOT_DOMAIN/webhook"
    fi
    echo "✅ Webhook URL خودکار: $WEBHOOK_URL"
fi

echo ""
echo "--- تنظیم فایل کانفیگ ---"

CONFIG_FILE="$BOT_DIR/config.php"

if [ ! -f "$CONFIG_FILE" ]; then
    cat > "$CONFIG_FILE" << 'PHPEOF'
<?php
// Mirza Pro Configuration
// تنظیمات Mirza Pro

// اطلاعات ربات
define('BOT_TOKEN', getenv('BOT_TOKEN') ?: 'YOUR_BOT_TOKEN');
define('BOT_USERNAME', getenv('BOT_USERNAME') ?: 'your_bot_username');
define('ADMIN_ID', (int)(getenv('ADMIN_ID') ?: 0));

// اطلاعات دیتابیس
define('DB_HOST', 'localhost');
define('DB_NAME', getenv('DB_NAME') ?: 'mirzaprobot');
define('DB_USER', getenv('DB_USER') ?: 'root');
define('DB_PASSWORD', getenv('DB_PASSWORD') ?: 'mirzapro_secure_2024');
define('DB_PORT', 3306);

// URL‌های ربات
define('BOT_DOMAIN', getenv('BOT_DOMAIN') ?: 'localhost');
define('BOT_WEBHOOK_URL', getenv('WEBHOOK_URL') ?: 'https://YOUR_DOMAIN.railway.app/webhook');

// تنظیمات امنیتی
define('WEBHOOK_SECRET', getenv('WEBHOOK_SECRET') ?: 'your_webhook_secret_key');

// تنظیمات پیشرفته
define('DEBUG_MODE', getenv('DEBUG_MODE') ?: false);
define('LOG_LEVEL', getenv('LOG_LEVEL') ?: 'INFO');

// پنل‌های پشتیبانی‌شده
define('SUPPORTED_PANELS', [
    'marzban',
    'marzneshin',
    'sanaei',
    'alireza',
    's-ui',
    'hiddify'
]);

// درگاه‌های پرداخت
define('PAYMENT_GATEWAYS', [
    'zarinpal',
    'perfect_money',
    'coinbase',
    'ethereum'
]);

// تنظیمات محدودیت قیمت
define('MIN_PRICE', (float)(getenv('MIN_PRICE') ?: 1000));
define('MAX_PRICE', (float)(getenv('MAX_PRICE') ?: 1000000));

// تاریخ و ساعت
date_default_timezone_set('Asia/Tehran');

// سطح خطا
error_reporting(E_ALL);
ini_set('display_errors', getenv('DEBUG_MODE') ? '1' : '0');

?>
PHPEOF
    
    echo "✅ فایل کانفیگ ایجاد شد"
else
    echo "✅ فایل کانفیگ موجود است"
fi

echo ""
echo "--- ذخیره رمز عبور دیتابیس ---"
echo "$DB_PASSWORD" > /root/mirza_pass.txt
chmod 600 /root/mirza_pass.txt
echo "✅ رمز عبور ذخیره شد (در /root/mirza_pass.txt)"

echo ""
echo "--- چاپ معلومات مهم ---"
echo "=================================="
echo "📊 اطلاعات راه‌اندازی Mirza Pro"
echo "=================================="
echo "🗄️  نام دیتابیس: $DB_NAME"
echo "👤 کاربر دیتابیس: $DB_USER"
echo "🔐 رمز: ذخیره‌شده در /root/mirza_pass.txt"
echo "🌐 دامنه: $BOT_DOMAIN"
echo "🔗 Webhook: $WEBHOOK_URL"
echo "=================================="
echo ""
echo "⚠️  مهم: متغیرهای زیر را در Railway تنظیم کنید:"
echo "   - BOT_TOKEN (الزامی)"
echo "   - ADMIN_ID (الزامی)"
echo "   - BOT_USERNAME (الزامی)"
echo "   - WEBHOOK_URL (بهتر است تنظیم شود)"
echo ""

echo "--- شروع Supervisor (مدیریت سرویس‌ها) ---"
exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisor.conf
