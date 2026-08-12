# 🆕 نسخه جدید - استفاده خودکار دامنه‌های عمومی Railway

## 🎯 چه تغیر کرد؟

### قدیمی ❌
```
شما: "BOT_DOMAIN و WEBHOOK_URL را خود بگذار"
آدم: "چطور؟ کجا؟ چی کار کنم؟"
```

### جدید ✅
```
سیستم: "من دامنه رو شناسایی کنم و خودکار تنظیم کنم"
آدم: "فقط توکن ربات بگذار!"
```

---

## 📦 فایل‌های جدید

### 1️⃣ **setup-webhook.php** (جدید)
**چه کار می‌کند:**
- ✅ وضعیت Webhook را بررسی می‌کند
- ✅ Webhook را خودکار تنظیم می‌کند
- ✅ دامنه عمومی را تشخیص می‌دهد

**استفاده:**
```
https://mirza-pro-xyz.railway.app/setup-webhook.php
```

### 2️⃣ **webhook.php** (جدید)
**چه کار می‌کند:**
- ✅ پیام‌های Telegram را دریافت می‌کند
- ✅ بررسی امنیتی Secret Token
- ✅ لاگ کردن تمام فعالیت‌ها

**استفاده:**
```
Telegram خودکار ارسال می‌کند
(شما نیاز نیست دستی استفاده کنید)
```

### 3️⃣ **RAILWAY_AUTO_DOMAIN_GUIDE.md** (جدید)
**چه کار می‌کند:**
- ✅ راهنمای کامل خودکار
- ✅ مثال‌های عملی
- ✅ حل مشکل‌ها

---

## ⚡ تغییرات فایل‌های قدیمی

| فایل | تغییر |
|------|--------|
| **entrypoint.sh** | تشخیص خودکار دامنه + webhook.php کپی‌شد |
| **Dockerfile** | setup-webhook.php و webhook.php اضافه شد |
| **docker-compose.yml** | متغیرهای جدید |
| **.env.example** | نکات خودکار اضافه شد |

---

## 🚀 استفاده سریع

### فقط 2 بخش:

```env
# بخش 1: توکن ربات (الزامی)
BOT_TOKEN=توکن_شما
BOT_USERNAME=نام_ربات
ADMIN_ID=شناسه_ادمین
WEBHOOK_SECRET=کلید_محرمانه

# بخش 2: بقیه (اختیاری - خودکار!)
BOT_DOMAIN=
WEBHOOK_URL=
RAILWAY_PUBLIC_DOMAIN=auto
```

**بیشتر نیست!** ✅

---

## 📊 چه اتفاق می‌افتد؟

```
1. شما: متغیرها را می‌گذارید
                    ↓
2. Railway: Container شروع می‌کند
                    ↓
3. entrypoint.sh: RAILWAY_PUBLIC_DOMAIN را پیدا می‌کند
                    ↓
4. Script: BOT_DOMAIN و WEBHOOK_URL را خودکار تعریف می‌کند
                    ↓
5. PHP: Webhook را خودکار تنظیم می‌کند (setup-webhook.php)
                    ↓
6. Telegram: پیام‌ها ارسال می‌کند (webhook.php دریافت می‌کند)
                    ↓
7. ✅ Done!
```

---

## 🔍 نمایش محل‌های دسترسی

### صفحات جدید:

```
Health Check (بررسی سلامت):
https://domain.railway.app/health.php

Setup Webhook (تنظیم Webhook):
https://domain.railway.app/setup-webhook.php

Check Webhook Status (بررسی وضعیت):
https://domain.railway.app/setup-webhook.php?action=check

Webhook Receiver (دریافت پیام‌ها):
https://domain.railway.app/webhook
```

---

## ✅ 3 دقیقه تا Ready

### مرحله 1 (1 دقیقه)
```
متغیرهایتان را بگذارید:
BOT_TOKEN, ADMIN_ID, ...
```

### مرحله 2 (30 ثانیه)
```
Deploy کلیک کنید
```

### مرحله 3 (1.5 دقیقه)
```
صبر کنید تا کامل شود
لاگ‌ها را بررسی کنید
```

### Done ✅
```
ربات جاه است!
```

---

## 📝 متغیرهای مهم

### الزامی (شما بگذارید):
```
BOT_TOKEN          - توکن ربات
BOT_USERNAME       - نام ربات
ADMIN_ID           - شناسه ادمین
WEBHOOK_SECRET     - کلید محرمانه (برای امنیت)
```

### خودکار (نگذارید):
```
RAILWAY_PUBLIC_DOMAIN  - Railway خودکار می‌کند
BOT_DOMAIN             - خودکار شناسایی
WEBHOOK_URL            - خودکار ساخت
```

---

## 🎯 نقاط مهم

✅ **خودکار است** - نیاز نیست دستی Webhook تنظیم کنید

✅ **ایمن است** - Secret Token برای امنیت

✅ **سریع است** - تمام چیز خودکار

✅ **آسان است** - بدون تجربه استفاده کنید

---

## 📚 راهنماها

| فایل | برای |
|------|------|
| **RAILWAY_AUTO_DOMAIN_GUIDE.md** | 📖 توضیح کامل |
| **RAILWAY_DEPLOYMENT_GUIDE.md** | 📘 راهنمای دستی (قدیمی) |
| **TROUBLESHOOTING.md** | 🔧 حل مشکل‌ها |
| **README.md** | 🎯 شروع سریع |

---

## 🚨 اگر مشکل دارید

### مشکل 1: دامنه تشخیص نشد
```
حل: صبر کنید، Deploy کامل شود
لاگ را بررسی کنید: railway logs
```

### مشکل 2: Webhook تنظیم نشد
```
حل: BOT_TOKEN را بررسی کنید
صفحه بررسی بروید: /setup-webhook.php?action=check
```

### مشکل 3: ربات جواب ندهد
```
حل: WEBHOOK_SECRET را بررسی کنید
لاگ‌های webhook را بررسی کنید:
tail -f /var/www/html/mirzaprobotconfig/logs/webhook_*.log
```

---

## 🎁 تزیین‌های اضافی

✨ **Health Check:** `https://domain.railway.app/health.php`
- بررسی سلامت سرویس‌ها
- PHP، MySQL، فایل‌ها

✨ **Setup Webhook:** `https://domain.railway.app/setup-webhook.php`
- بررسی وضعیت Webhook
- تنظیم خودکار

✨ **Webhook Logs:** `/mirzaprobotconfig/logs/webhook_*.log`
- تمام فعالیت‌های ربات

---

## 🎉 خلاصه

**قدیمی:**
- 10 متغیر دستی
- 5 مرحله دستی
- مشکل‌های زیاد

**جدید:**
- 4 متغیر فقط
- خودکار کامل
- بدون مشکل! ✅

---

**شروع کنید: RAILWAY_AUTO_DOMAIN_GUIDE.md** 📖

