# 📦 نسخه جدید: Mirza Pro با دامنه‌های عمومی خودکار Railway

## 🎊 خوشآمدید!

این نسخه **تمام‌تر** و **خودکار‌تر** است!

---

## 🆕 تغییرات اصلی

### ✨ خودکار دامنه عمومی
```
قبل: "شما باید دامنه رو بگذاری"
الآن: "من خودم دامنه رو شناسایی می‌کنم"
```

### ✨ Webhook خودکار
```
قبل: "دستی لینک Telegram API رو صدا کن"
الآن: "من خودم Webhook رو تنظیم می‌کنم"
```

### ✨ فایل‌های جدید
```
setup-webhook.php   - برای تنظیم و بررسی Webhook
webhook.php         - برای دریافت پیام‌های Telegram
```

---

## 📋 فهرست فایل‌های موجود

### 🔴 فایل‌های اصلی (ضروری)
1. **Dockerfile** - تعریف Container
2. **entrypoint.sh** - راه‌اندازی خودکار ✨ بروزرسانی شد
3. **docker-compose.yml** - برای تست محلی ✨ بروزرسانی شد
4. **.env.example** - متغیرهای نمونه ✨ بروزرسانی شد

### 🟢 فایل‌های تنظیمات
5. **apache.conf** - تنظیمات Apache
6. **supervisor.conf** - مدیریت سرویس‌ها

### 🆕 فایل‌های جدید
7. **setup-webhook.php** - تنظیم Webhook خودکار 🆕
8. **webhook.php** - دریافت پیام‌های Telegram 🆕
9. **health.php** - بررسی سلامت

### 📚 راهنماهای فارسی
10. **RAILWAY_AUTO_DOMAIN_GUIDE.md** - راهنمای دامنه خودکار 🆕
11. **WHATS_NEW_FARSI.md** - خلاصه تغییرات 🆕
12. **RAILWAY_DEPLOYMENT_GUIDE.md** - راهنمای دستی (قدیمی)
13. **TROUBLESHOOTING.md** - حل مشکل‌ها
14. **README.md** - شروع سریع
15. **FILES_SUMMARY_FARSI.md** - توضیح تمام فایل‌ها

### 🚀 ابزارهای تست
16. **QUICK_START_LOCAL.sh** - اسکریپت تست محلی

---

## 🎯 شروع سریع (درست از جعبه!)

### Step 1: متغیرهای الزامی (فقط 4 تا!)

```env
BOT_TOKEN=توکن_ربات_خود
BOT_USERNAME=نام_کاربری_ربات
ADMIN_ID=شناسه_ادمین_شما
WEBHOOK_SECRET=کلید_محرمانه_دلخواه
```

### Step 2: Deploy کنید

```
railway.app وارد شوید
متغیرها را بگذارید
Deploy کلیک کنید
```

### Step 3: صبر کنید (2 دقیقه)

```
Mirza Pro شروع می‌شود
دامنه خودکار شناسایی می‌شود
Webhook خودکار تنظیم می‌شود
```

### Done ✅

```
ربات جاه است!
```

---

## ⚡ چه چیزهایی خودکار هستند؟

| عملیات | قبل | الآن |
|--------|------|------|
| دامنه | ❌ دستی | ✅ خودکار |
| Webhook | ❌ دستی | ✅ خودکار |
| متغیرها | ❌ 10+ | ✅ 4 |
| مراحل | ❌ 10+ | ✅ 3 |
| مشکل‌ها | ❌ زیاد | ✅ کم |

---

## 🔧 فایل‌های جدید - شرح کوتاه

### 1️⃣ setup-webhook.php (جدید)

**آدرس:**
```
https://domain.railway.app/setup-webhook.php
```

**کاربرد:**
- بررسی وضعیت Webhook
- تنظیم خودکار Webhook
- شناسایی دامنه

**استفاده:**
```bash
# بررسی
https://domain.railway.app/setup-webhook.php?action=check

# تنظیم
curl -X POST https://domain.railway.app/setup-webhook.php
```

### 2️⃣ webhook.php (جدید)

**آدرس:**
```
https://domain.railway.app/webhook
```

**کاربرد:**
- دریافت پیام‌های Telegram
- بررسی Security Token
- ثبت لاگ‌ها

**استفاده:**
- خودکار توسط Telegram
- شما نیاز نیست دستی استفاده کنید

### 3️⃣ entrypoint.sh (بروزرسانی‌شده)

**تغییرات:**
- تشخیص خودکار RAILWAY_PUBLIC_DOMAIN
- تنظیم خودکار BOT_DOMAIN
- ساخت خودکار WEBHOOK_URL
- کپی webhook.php

### 4️⃣ docker-compose.yml (بروزرسانی‌شده)

**تغییرات:**
- اضافه کردن RAILWAY_PUBLIC_DOMAIN
- نوتیشن‌های جدید
- متغیرهای بهتر

### 5️⃣ .env.example (بروزرسانی‌شده)

**تغییرات:**
- ⚠️ نکات خودکار
- توضیحات بهتر
- ترتیب بهتر

---

## 📚 راهنماها - کدام را بخوانیم؟

### 🔴 اگر تازه‌کار هستید:
1. **WHATS_NEW_FARSI.md** بخوانید (3 دقیقه)
2. **RAILWAY_AUTO_DOMAIN_GUIDE.md** بخوانید (5 دقیقه)
3. شروع کنید! ✅

### 🟡 اگر سؤال دارید:
1. **RAILWAY_AUTO_DOMAIN_GUIDE.md** بروید
2. "حل مشکل‌ها" بخش را بخوانید
3. سؤالتان پاسخ داده خواهد شد

### 🔵 اگر مشکل دارید:
1. **TROUBLESHOOTING.md** بروید
2. مشکلتان را جستجو کنید
3. راه‌حل را دنبال کنید

### 🟢 اگر نیاز دارید توضیح دقیق:
1. **RAILWAY_DEPLOYMENT_GUIDE.md** (راهنمای قدیمی)
2. این برای توضیحات بیشتر است

---

## 🚀 مقایسه نسخه‌ها

### نسخه قدیمی (بدون خودکار)
```
❌ 10+ متغیر دستی
❌ 5+ مرحله دستی
❌ تنظیم دستی Webhook
❌ مشکل‌های زیاد
```

### نسخه جدید (خودکار)
```
✅ 4 متغیر فقط
✅ 3 مرحله فقط
✅ Webhook خودکار
✅ بدون مشکل!
```

---

## ✅ تکمیل‌شدگی بررسی

بعد از Deploy:

- [ ] صفحه health.php کار می‌کند؟
  ```
  https://domain.railway.app/health.php
  ```

- [ ] setup-webhook.php موفق است؟
  ```
  https://domain.railway.app/setup-webhook.php?action=check
  ```

- [ ] ربات در Telegram جواب می‌دهد؟

- [ ] لاگ‌ها خطا ندارند؟
  ```
  railway logs
  ```

---

## 🎁 بونوس‌ها

✨ **Health Check:** بررسی سلامت خودکار
✨ **Webhook Setup:** تنظیم و بررسی Webhook
✨ **Security:** Secret Token برای امنیت
✨ **Logging:** ثبت تمام فعالیت‌ها

---

## 📞 پشتیبانی سریع

### Q: آیا باید دامنه دستی بگذارم؟
**A:** نه! خودکار شناسایی می‌شود

### Q: Webhook خودکار تنظیم می‌شود؟
**A:** بله! entrypoint.sh انجام می‌دهد

### Q: چی اگر مشکل پیش آید؟
**A:** TROUBLESHOOTING.md را بخوانید

### Q: نسخه قدیمی هنوز کار می‌کند؟
**A:** بله! نسخه جدید backwards compatible است

---

## 🚀 حالا بروید و استقرار دهید!

```
1. متغیرها: 1 دقیقه
2. Deploy: 30 ثانیه
3. صبر: 2 دقیقه
4. Done: ✅
```

**کل: 3.5 دقیقه!**

---

## 📖 جای شروع

**اول:** `WHATS_NEW_FARSI.md` (این فایل)
**دوم:** `RAILWAY_AUTO_DOMAIN_GUIDE.md` (راهنما)
**سوم:** Deploy in Railway

**موفق باشید!** 🎉

---

## 🔗 فایل‌های اهم

| فایل | اهمیت | نوع |
|------|--------|------|
| RAILWAY_AUTO_DOMAIN_GUIDE.md | ⭐⭐⭐ | راهنما |
| setup-webhook.php | ⭐⭐⭐ | تابع |
| entrypoint.sh | ⭐⭐⭐ | اسکریپت |
| TROUBLESHOOTING.md | ⭐⭐ | راهنما |
| WHATS_NEW_FARSI.md | ⭐⭐ | اطلاع |

---

**🎊 خوشامد به نسخه جدید!**

