# 🚀 راهنمای استفاده دامنه‌های عمومی Railway (نسخه خودکار)

## 🎯 چیست این نسخه؟

این نسخه **خودکار** دامنه عمومی Railway را تشخیص داده و استفاده می‌کند!

```
❌ قدیمی: دستی دامنه را بگذاریم
✅ جدید: خودکار شناسایی و تنظیم
```

---

## 🌐 دامنه‌های عمومی Railway

### چیست؟
```
https://mirza-pro-abc123.railway.app
```

**مشخصات:**
- ✅ رایگان
- ✅ خودکار ایجاد می‌شود
- ✅ HTTPS با SSL رایگان
- ✅ Telegram می‌تواند استفاده کند

### کجا می‌بینم؟

**در Railway Dashboard:**
```
1. پروژه خود را باز کنید
2. سرویس Mirza Pro کلیک کنید
3. "Networking" تب
4. "Public URL" کپی کنید
   👇 مثال:
   https://mirza-pro-xyz789.railway.app
```

---

## ⚙️ چگونه خودکار کار می‌کند؟

### 1️⃣ شروع Container

```bash
# entrypoint.sh شروع می‌شود
↓
# محیط‌های Railway را بررسی می‌کند
↓
# RAILWAY_PUBLIC_DOMAIN را پیدا می‌کند
↓
# BOT_DOMAIN را خودکار تنظیم می‌کند
↓
# WEBHOOK_URL را خودکار ساخت می‌کند
```

### 2️⃣ متغیرهای محیط‌ایی

**Railway خودکار تعریف می‌کند:**
```
$RAILWAY_PUBLIC_DOMAIN = mirza-pro-xyz789.railway.app
```

**Script خودکار استفاده می‌کند:**
```bash
BOT_DOMAIN = $RAILWAY_PUBLIC_DOMAIN
WEBHOOK_URL = https://$BOT_DOMAIN/webhook
```

### 3️⃣ نتیجه

**خودکار:**
```
✅ BOT_DOMAIN = mirza-pro-xyz789.railway.app
✅ WEBHOOK_URL = https://mirza-pro-xyz789.railway.app/webhook
✅ Webhook خودکار تنظیم می‌شود
```

---

## 📋 متغیرهای مورد نیاز

### الزامی:
```env
BOT_TOKEN=توکن_ربات_خود
BOT_USERNAME=نام_کاربری_ربات
ADMIN_ID=شناسه_ادمین
WEBHOOK_SECRET=کلید_محرمانه
```

### اختیاری (خودکار):
```env
# خالی بگذارید - Railway خودکار می‌کند!
BOT_DOMAIN=
WEBHOOK_URL=
RAILWAY_PUBLIC_DOMAIN=auto
```

---

## 🎯 مراحل راه‌اندازی

### مرحله 1: در محلی (اختیاری)

```bash
# تست قبل از Railway
docker-compose up

# متغیرها را مشاهده کنید
docker logs mirza-pro-railway

# باید ببینید:
# ✅ دامنه Railway تشخیص داده شد: localhost:80
```

### مرحله 2: در Railway

```
1. پروژه درست کنید (Deploy from GitHub)
2. متغیرهای الزامی را بگذارید:
   - BOT_TOKEN
   - BOT_USERNAME
   - ADMIN_ID
   - WEBHOOK_SECRET

3. متغیرهای دیگر را خالی بگذارید
   (خودکار تنظیم می‌شوند)

4. Deploy کنید
```

### مرحله 3: بررسی

**بعد از 2-3 دقیقه:**

```bash
# لاگ‌ها بررسی کنید
railway logs

# باید ببینید:
# ✅ دامنه Railway تشخیص داده شد: mirza-pro-xyz789.railway.app
# ✅ Webhook URL خودکار: https://mirza-pro-xyz789.railway.app/webhook
```

---

## 🔧 تنظیم دستی Webhook (اختیاری)

### روش 1️⃣: استفاده از setup-webhook.php

**بررسی وضعیت:**
```
https://mirza-pro-xyz789.railway.app/setup-webhook.php?action=check
```

**نمونه جواب:**
```json
{
  "status": "success",
  "current_webhook": "https://mirza-pro-xyz789.railway.app/webhook",
  "match": "✅ تطابق دارد"
}
```

**تنظیم Webhook:**
```
POST https://mirza-pro-xyz789.railway.app/setup-webhook.php
```

یا دستور cURL:
```bash
curl -X POST https://mirza-pro-xyz789.railway.app/setup-webhook.php
```

**جواب:**
```json
{
  "status": "success",
  "message": "✅ Webhook با موفقیت تنظیم شد!",
  "webhook_url": "https://mirza-pro-xyz789.railway.app/webhook"
}
```

### روش 2️⃣: استفاده از Telegram API

```bash
# دستور اتصال
https://api.telegram.org/bot{TOKENخود}/setWebhook?url=https://mirza-pro-xyz789.railway.app/webhook&secret_token=your_secret
```

**موفقیت:**
```json
{
  "ok": true,
  "result": {
    "url": "https://mirza-pro-xyz789.railway.app/webhook",
    "has_custom_certificate": false,
    "pending_update_count": 0
  }
}
```

---

## 📊 فایل‌های اصلی

| فایل | تغییر |
|------|--------|
| **entrypoint.sh** | ✏️ تعدیل‌شده - تشخیص خودکار دامنه |
| **setup-webhook.php** | 🆕 جدید - تنظیم Webhook خودکار |
| **Dockerfile** | ✏️ تعدیل‌شده - کپی فایل‌های جدید |
| **docker-compose.yml** | ✏️ تعدیل‌شده - متغیرهای جدید |
| **.env.example** | ✏️ تعدیل‌شده - متغیرهای اختیاری |

---

## ⚡ مثال عملی

### متغیرهای فقط لازم:

```env
BOT_TOKEN=123456789:ABCDefGH...
BOT_USERNAME=my_vpn_bot
ADMIN_ID=987654321
WEBHOOK_SECRET=my_secret_key_123

# فقط این‌ها! بقیه خودکار است!
```

### نتیجه خودکار:

```
Railway شروع می‌شود ↓
    ↓
RAILWAY_PUBLIC_DOMAIN = my-bot-xyz.railway.app ↓
    ↓
entrypoint.sh آن را تشخیص می‌دهد ↓
    ↓
BOT_DOMAIN = my-bot-xyz.railway.app ↓
WEBHOOK_URL = https://my-bot-xyz.railway.app/webhook ↓
    ↓
✅ کامل! ربات جاه است
```

---

## 🔍 حل مشکل‌ها

### مشکل: دامنه تشخیص نشد

```bash
# لاگ را بررسی کنید
railway logs

# باید ببینید:
# ⚠️  از دامنه محلی استفاده می‌شود: localhost:8080

# حل: صبر کنید تا Deploy کامل شود
```

### مشکل: Webhook تنظیم نشد

```bash
# بررسی وضعیت:
https://domain.railway.app/setup-webhook.php?action=check

# اگر خطا داشت:
# 1. BOT_TOKEN بررسی کنید
# 2. WEBHOOK_SECRET بررسی کنید
# 3. دوباره Deploy کنید
```

### مشکل: لاگ تهی است

```bash
# صبر کنید 30 ثانیه
# ربات نیاز دارد تا سرویس‌ها شروع شوند

# سپس:
railway logs -f  # دنبال لاگ‌های جدید
```

---

## ✅ بررسی نهایی

بعد از Deploy، بررسی کنید:

- [ ] صفحه `https://domain.railway.app/health.php` کار می‌کند؟
- [ ] صفحه `https://domain.railway.app/setup-webhook.php?action=check` موفق است؟
- [ ] ربات در تلگرام جواب می‌دهد؟
- [ ] لاگ‌ها خطای دیتابیس ندارند؟

---

## 🎁 راهنمای سریع

```
3 دقیقه تا Ready:

1. متغیرها را بگذارید (BOT_TOKEN, ADMIN_ID, ...)
2. Deploy در Railway
3. صبر کنید 2 دقیقه
4. Done! ✅
```

---

## 📞 نکات مهم

⚠️ **هرگز تغییر ندهید:**
- RAILWAY_PUBLIC_DOMAIN (خودکار است)

✅ **حتما بگذارید:**
- BOT_TOKEN
- BOT_USERNAME  
- ADMIN_ID

💾 **خودکار تنظیم می‌شود:**
- BOT_DOMAIN
- WEBHOOK_URL

---

**🚀 حالا شما آماده هستید!**

Deploy کنید و ببینید چگونه خودکار کار می‌کند! ✨

