# 🔧 راهنمای حل مشکل‌ها

## 🚨 مشکل‌های رایج و راه‌حل‌ها

---

## 1️⃣ ربات جواب نمی‌دهد

### ⚠️ علائم:
- پیام بفرستید اما ربات جواب نمی‌دهد
- هیچ خطایی در Telegram نیست

### ✅ راه‌حل‌ها:

#### مرحله 1: بررسی توکن
```bash
# به این آدرس بروید (توکن خود را بگذارید)
https://api.telegram.org/bot123456789:ABCDefGH/getMe
```
اگر `"ok":true` نشان داد، توکن درست است.

#### مرحله 2: بررسی Webhook
```bash
# بررسی webhook
https://api.telegram.org/bot123456789:ABCDefGH/getWebhookInfo
```

**بررسی نکات:**
- `"has_custom_certificate":false` - درست است
- `"pending_update_count"` - اگر بزرگ است، مشکل وجود دارد

#### مرحله 3: تنظیم دوباره Webhook
```bash
# پاک کردن webhook
https://api.telegram.org/bot{TOKENخود}/setWebhook?url=

# تنظیم دوباره
https://api.telegram.org/bot{TOKENخود}/setWebhook?url=https://domain.railway.app/webhook&secret_token=secret123
```

#### مرحله 4: بررسی Logs
```bash
railway logs
```

**چه بگردید:**
- خطاهای PHP
- خطاهای دیتابیس
- خطاهای اتصال

---

## 2️⃣ خطای 502 Bad Gateway

### ⚠️ علائم:
- هنگام بازدید سایت: خطای 502
- Container شامل خطا شروع می‌شود

### ✅ راه‌حل‌ها:

#### گام 1: صبر کنید
```
⏳ 30-60 ثانیه صبر کنید
🔄 صفحه را رفرش کنید
```

#### گام 2: بررسی Logs
```bash
railway logs
```

**خطاهای عام:**
```
# MySQL درست شروع نشده
ERROR 2002: Can't connect to local MySQL server

➡️ حل: صبر بیشتری گذارید یا دوباره Deploy کنید
```

```
# فایل‌های گمشده
Fatal error: require()

➡️ حل: دانلود Mirza Pro را دوباره‌چک کنید
```

#### گام 3: دوباره Deploy
```bash
railway redeploy
```

---

## 3️⃣ خطای "Build Failed"

### ⚠️ علائم:
- Build متوقف می‌شود
- قرمز رنگ در Deployments

### ✅ راه‌حل‌ها:

#### مرحله 1: بررسی فایل‌ها
```
✅ Dockerfile موجود است؟
✅ فایل‌های .conf موجود هستند؟
✅ entrypoint.sh موجود است؟
```

#### مرحله 2: بررسی Syntax
```bash
# بررسی Dockerfile
docker build .

# اگر خطا نشان داد، مشکل ساختی است
```

#### مرحله 3: بررسی Git
```bash
# اطمینان دهید تمام فایل‌ها کمیت شده‌اند
git status

# فایل‌های گمشده را اضافه کنید
git add .
git commit -m "Fix build"
git push origin main
```

---

## 4️⃣ خطای "Connection refused" (دیتابیس)

### ⚠️ علائم:
```
Error: SQLSTATE[HY000]: General error: 2002 Can't connect to 
local MySQL server
```

### ✅ راه‌حل‌ها:

#### حل 1: صبر کنید
```
MySQL نیاز دارد 15-20 ثانیه برای شروع داشته باشد
صبر کنید و دوباره‌ی صفحه را بارگیری کنید
```

#### حل 2: دوباره شروع
```bash
railway redeploy
```

#### حل 3: بررسی رمز عبور
```
متغیرهای محیط‌ایی بررسی کنید:
- DB_PASSWORD درست است؟
- DB_NAME درست است؟
- DB_USER درست است؟
```

---

## 5️⃣ خطای "Permission denied"

### ⚠️ علائم:
```
Permission denied for file
Cannot write to directory
```

### ✅ راه‌حل‌ها:

```bash
# راه‌حل خودکار (در Container)
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html
```

**اگر دست‌کاری کنید:**
```bash
docker-compose exec mirza-pro bash
chown -R www-data:www-data /var/www/html/mirzaprobotconfig
chmod -R 777 /var/www/html/mirzaprobotconfig/uploads
```

---

## 6️⃣ Webhook تنظیم نمی‌شود

### ⚠️ علائم:
```
"ok":false, "error_code":400
```

### ✅ راه‌حل‌ها:

#### بررسی دامنه
```
صحیح: https://my-bot.railway.app/webhook
❌ غلط: http://my-bot.railway.app (بدون https!)
❌ غلط: localhost/webhook (محلی)
```

#### بررسی URL
```bash
# URL را تست کنید
curl -I https://your-domain.railway.app/webhook
```

**جواب صحیح:**
```
HTTP/2 200 OK
```

#### تنظیم دوباره
```bash
# پاک کردن
https://api.telegram.org/bot{TOKENخود}/setWebhook?url=

# تنظیم دوباره (صبر کنید 5 دقیقه)
https://api.telegram.org/bot{TOKENخود}/setWebhook?url=https://your-domain.railway.app/webhook
```

---

## 7️⃣ دیتابیس خالی است

### ⚠️ علائم:
- پیام: "Table not found"
- دیتابیس خالی است

### ✅ راه‌حل‌ها:

#### حل 1: منتظر بمانید
```
جداول در راه‌اندازی اول ایجاد می‌شوند
صبر کنید 5 دقیقه
```

#### حل 2: دوباره Deploy
```bash
railway redeploy
```

#### حل 3: چک کنید
```bash
# دسترسی به دیتابیس
railway tunnel

# اتصال محلی
mysql -h 127.0.0.1 -u root -p mirzaprobot
```

---

## 8️⃣ ربات آرام است یا سست

### ⚠️ علائم:
- فاصله‌ای میان ارسال و جواب
- بعضی پیام‌ها جواب نمی‌دهند

### ✅ راه‌حل‌ها:

#### بررسی منابع
```bash
# مشاهده استفاده
railway status
```

#### راه‌حل‌ها:
1. Worker‌ها را بیشتر کنید (MAX_INSTANCES)
2. دیتابیس را بهینه‌سازی کنید
3. لاگ‌های اضافی را خاموش کنید (DEBUG_MODE=false)

---

## 9️⃣ "Unauthorized" در Telegram

### ⚠️ علائم:
```
401 Unauthorized
Token was revoked
```

### ✅ راه‌حل‌ها:

#### توکن جدید بگیرید
1. [BotFather](https://t.me/BotFather) را باز کنید
2. `/token` بفرستید
3. ربات را انتخاب کنید
4. توکن جدید را کپی کنید

#### متغیر را به‌روزرسانی کنید
```
متغیر BOT_TOKEN را با توکن جدید بدهید
دوباره Deploy کنید
```

---

## 🔟 خطاهای درگاه پرداخت

### ⚠️ علائم:
```
Zarinpal: Invalid merchant ID
Perfect Money: Authentication failed
```

### ✅ راه‌حل‌ها:

#### Zarinpal
```
✅ Merchant ID درست است؟
✅ دامنه در Zarinpal ثبت شده است؟
✅ شنا قرارداد است؟
```

#### Perfect Money
```
✅ حساب فعال است؟
✅ رمز درست است؟
✅ IP فهرست‌سفید است؟
```

---

## 📋 درخواست کمک

اگر مشکل حل نشد، این اطلاعات را گردآوری کنید:

```
1. دقیق خطا (از Logs)
2. متغیرهای محیط‌ایی (بدون حساسیت)
3. آخرین تغییرات
4. زمان دقیق مشکل
```

---

## 🎯 نکات اصلی

| مشکل | سریع‌ترین حل |
|------|---------|
| 502 Bad Gateway | صبر 30 ثانیه + refresh |
| ربات جواب ندهد | Webhook را تنظیم دوباره کنید |
| دیتابیس | دوباره Deploy |
| Permission | صبر کنید (خودکار شود) |
| Slow | بیشتر instances بدهید |

---

**موفق باشید! 🎉**

اگر سؤال دارید، لاگ‌ها را بررسی کنید:
```bash
railway logs
```

