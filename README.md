# 🤖 Mirza Pro - استقرار روی Railway

نسخه Docker اپتیمیز‌شده **Mirza Pro** برای استقرار بدون نگرانی روی **Railway**.

## ✨ ویژگی‌ها

✅ **Docker بهینه‌شده** - دقیقاً برای Railway تنظیم‌شده
✅ **تمام وابستگی‌ها** - PHP، Apache، MySQL درون یک Container
✅ **خودکار** - راه‌اندازی خودکار و مدیریت خودکار
✅ **محفوظ** - رمز‌گذاری و متغیرهای محیط‌ایی
✅ **مقیاس‌پذیر** - پشتیبانی از بیشتر پنل‌های VPN

## 📋 پیش‌نیازها

- حساب GitHub (رایگان)
- حساب Railway (رایگان)
- توکن ربات تلگرام (از BotFather)

## 🚀 شروع سریع (5 دقیقه)

### 1️⃣ آماده‌سازی GitHub

```bash
git clone https://github.com/YOUR_USERNAME/mirza-pro-railway.git
cd mirza-pro-railway
# یا اینجا را fork کنید
```

### 2️⃣ اتصال به Railway

1. برو به [railway.app](https://railway.app)
2. **New Project** → **Deploy from GitHub**
3. Repository خود را انتخاب کنید
4. **Deploy** کلیک کنید

### 3️⃣ تنظیم متغیرهای محیط‌ایی

در **Variables**:

```
BOT_TOKEN=توکن_ربات_خود
BOT_USERNAME=نام_کاربری_ربات
ADMIN_ID=شناسه_ادمین
PANEL_TYPE=marzban
PANEL_URL=https://panel-url.com
PANEL_USERNAME=admin
PANEL_PASSWORD=password
PAYMENT_GATEWAY=zarinpal
ZARINPAL_MERCHANT=merchant_id
```

### 4️⃣ تنظیم Webhook

```bash
https://api.telegram.org/bot{BOT_TOKEN}/setWebhook?url=https://your-domain.railway.app/webhook
```

## 📚 فایل‌های موجود

| فایل | توضیح |
|------|--------|
| `Dockerfile` | تعریف Container |
| `docker-compose.yml` | برای تست محلی |
| `entrypoint.sh` | اسکریپت راه‌اندازی |
| `apache.conf` | تنظیمات Apache |
| `supervisor.conf` | مدیریت سرویس‌ها |
| `.env.example` | نمونه متغیرها |
| `RAILWAY_DEPLOYMENT_GUIDE.md` | راهنمای تفصیلی (فارسی) |

## 🔧 تنظیمات پنل‌های پشتیبانی‌شده

### Marzban
```
PANEL_TYPE=marzban
PANEL_URL=https://marzban.example.com
```

### Marzneshin
```
PANEL_TYPE=marzneshin
PANEL_URL=https://marzneshin.example.com
```

### Sanaei / Alireza
```
PANEL_TYPE=sanaei
PANEL_URL=https://panel.example.com
```

### S-UI
```
PANEL_TYPE=s-ui
PANEL_URL=https://s-ui.example.com
```

## 💳 درگاه‌های پرداخت پشتیبانی‌شده

- **Zarinpal** - درگاه ایرانی
- **Perfect Money** - درگاه بین‌المللی
- **Coinbase** - رمزارز
- **Ethereum** - بلاک‌چین

## 📊 نمایش‌گاه لاگ

```bash
railway logs
```

## 🛠️ حل مشکل‌های عمومی

### ربات جواب نمی‌دهد
- ✅ BOT_TOKEN را بررسی کنید
- ✅ Webhook URL صحیح است
- ✅ Logs را بررسی کنید

### خطای دیتابیس
- ✅ DB_PASSWORD را بررسی کنید
- ✅ دانشگاه‌های محدودیت ربات را بررسی کنید
- ✅ دوباره Deploy کنید

### خطای 502 Bad Gateway
- ⏳ صبر کنید 30-60 ثانیه
- 🔄 صفحه را رفرش کنید
- 📋 Logs را بررسی کنید

## 📖 مستندات کامل

برای راهنمای تفصیلی (فارسی) از `RAILWAY_DEPLOYMENT_GUIDE.md` استفاده کنید.

## 🤝 مشارکت

اگر بهبودی پیدا کردید:
1. Fork کنید
2. شاخه‌ای بسازید (`git checkout -b feature`)
3. Commit کنید (`git commit -m 'Add feature'`)
4. Push کنید (`git push origin feature`)
5. Pull Request باز کنید

## ⚠️ توجه‌هایی مهم

⚠️ **رمز دیتابیس** - رمزی قوی بگذارید!
⚠️ **متغیرهای محیط‌ایی** - هرگز با دیگران شریک‌نکنید
⚠️ **Webhook** - دقیق تنظیم کنید

## 📞 درخواست کمک

اگر مشکل دارید:
1. لاگ‌ها را بررسی کنید
2. متغیرها را دوباره‌چک کنید
3. دوباره Deploy کنید

## 📝 لایسنس

این پروژه برای استفاده شخصی و تجاری تحت لایسنس MIT است.

---

**ساخت شده با ❤️ برای Mirza Pro**

*نسخه: 1.0.0*
*آخرین‌بار به‌روزرسانی: آگست 2024*

