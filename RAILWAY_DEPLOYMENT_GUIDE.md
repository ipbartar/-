# 📚 راهنمای کامل استقرار Mirza Pro روی Railway

## 🎯 فهرست محتویات
1. [پیش‌نیازها](#پیش‌نیازها)
2. [مرحله 1: تهیه و آماده‌سازی](#مرحله-1-تهیه-و-آماده‌سازی)
3. [مرحله 2: اتصال به Railway](#مرحله-2-اتصال-به-railway)
4. [مرحله 3: تنظیمات متغیرهای محیط‌ایی](#مرحله-3-تنظیمات-متغیرهای-محیط‌ایی)
5. [مرحله 4: راه‌اندازی](#مرحله-4-راه‌اندازی)
6. [مرحله 5: تنظیمات Webhook](#مرحله-5-تنظیمات-webhook)
7. [مشکل‌یابی و راه‌حل‌ها](#مشکل‌یابی-و-راه‌حل‌ها)

---

## پیش‌نیازها

قبل از شروع، این موارد را فراهم کنید:

### 1️⃣ ربات تلگرام
- یک ربات از طریق **BotFather** درست کنید
- **چگونه؟**
  - در تلگرام، **@BotFather** را جستجو کنید
  - دستور `/start` را بفرستید
  - دستور `/newbot` را بفرستید
  - نام ربات را وارد کنید (مثال: `MyVPNBot`)
  - نام کاربری ربات را وارد کنید (مثال: `my_vpn_bot`) - **بدون @**
  - **توکن** را کپی کنید و ذخیره کنید (چیزی مثل: `123456:ABC-DEF1234ghIkl-zyx57W2v1u123ew11`)

### 2️⃣ شناسه ادمین تلگرام
- برای یافتن شناسه خود:
  - یک پیام به ربات بفرستید
  - `https://api.telegram.org/bot{توکن}/getUpdates` را در مرورگر باز کنید
  - جایی که `{توکن}` را با توکن ربات جایگزین کنید
  - در جواب، `"id":123456789` را پیدا کنید - این شناسه شماست

### 3️⃣ حساب Railway
- به [railway.app](https://railway.app) بروید
- ثبت‌نام کنید (می‌توانید از GitHub استفاده کنید)

### 4️⃣ اطلاعات پنل VPN
- آدرس پنل VPN خود (مثال: `vpn-panel.example.com`)
- نام کاربری و رمز عبور ادمین
- نوع پنل (Marzban یا دیگری)

---

## مرحله 1: تهیه و آماده‌سازی

### گام 1.1: آماده‌سازی فایل‌ها

تمام فایل‌های زیر را در یک پوشه قرار دهید:

```
my-mirza-pro/
├── Dockerfile
├── docker-compose.yml
├── entrypoint.sh
├── apache.conf
├── supervisor.conf
├── .env.example
└── README.md
```

### گام 1.2: تنظیم Git Repository

اگر Git ندارید، دانلود کنید: [git-scm.com](https://git-scm.com/download)

سپس در خط فرمان:

```bash
# وارد پوشه بروید
cd my-mirza-pro

# Git را شروع کنید
git init

# تمام فایل‌ها را اضافه کنید
git add .

# تغییرات را ذخیره کنید
git commit -m "Initial Mirza Pro setup for Railway"

# شاخه اصلی را تنظیم کنید
git branch -M main
```

### گام 1.3: ایجاد Repository در GitHub

1. به [github.com](https://github.com) بروید
2. روی **+** در گوشه بالا کلیک کنید
3. **New repository** انتخاب کنید
4. نام بگذارید: `mirza-pro-railway`
5. **Public** یا **Private** انتخاب کنید
6. **Create repository** کلیک کنید

سپس دستورات داده‌شده را کپی و چسباندن کنید:

```bash
git remote add origin https://github.com/YOUR_USERNAME/mirza-pro-railway.git
git push -u origin main
```

> **نکته:** `YOUR_USERNAME` را با نام کاربری GitHub خود جایگزین کنید

---

## مرحله 2: اتصال به Railway

### گام 2.1: وارد شدن به Railway

1. به [railway.app](https://railway.app) بروید
2. **Login** کلیک کنید
3. از GitHub ورود کنید

### گام 2.2: ایجاد پروژه جدید

1. روی **+ New Project** کلیک کنید
2. **Deploy from GitHub repo** انتخاب کنید
3. Repository خود را انتخاب کنید (`mirza-pro-railway`)
4. **Deploy** کلیک کنید

> Railway خودکار فایل Dockerfile را تشخیص داده و شروع به ساخت می‌کند

---

## مرحله 3: تنظیمات متغیرهای محیط‌ایی

### گام 3.1: وارد شدن به داشبورد

در صفحه پروژه Railway:
1. **Variables** تب را کلیک کنید

### گام 3.2: اضافه کردن متغیرها

روی **+ Add Variable** کلیک کنید و این‌ها را یکی یکی اضافه کنید:

#### 🤖 متغیرهای ربات (الزامی)

| نام | مثال | توضیح |
|------|--------|--------|
| `BOT_TOKEN` | `123456789:ABCDefGH...` | توکن ربات (از BotFather) |
| `BOT_USERNAME` | `my_vpn_bot` | نام کاربری ربات بدون @ |
| `ADMIN_ID` | `123456789` | شناسه ادمین |

#### 📊 متغیرهای دیتابیس

| نام | مقدار پیش‌فرض | توضیح |
|------|--------|--------|
| `DB_NAME` | `mirzaprobot` | نام دیتابیس |
| `DB_USER` | `root` | کاربر دیتابیس |
| `DB_PASSWORD` | **تغییر دهید!** | رمز قوی (حروف، اعداد، علامت‌ها) |

#### 🌐 متغیرهای دامنه

| نام | مثال | توضیح |
|------|--------|--------|
| `BOT_DOMAIN` | `my-bot.railway.app` | دامنه Railway |
| `WEBHOOK_URL` | `https://my-bot.railway.app/webhook` | آدرس کامل webhook |
| `WEBHOOK_SECRET` | `your_secure_secret_123` | کلید محرمانه |

#### 📊 متغیرهای پنل

| نام | مثال | توضیح |
|------|--------|--------|
| `PANEL_TYPE` | `marzban` | نوع پنل: marzban, marzneshin, sanaei |
| `PANEL_URL` | `https://vpn.example.com` | آدرس پنل VPN |
| `PANEL_USERNAME` | `admin` | نام کاربری پنل |
| `PANEL_PASSWORD` | `panel_pass` | رمز عبور پنل |

#### 💳 متغیرهای درگاه پرداخت

| نام | مثال | توضیح |
|------|--------|--------|
| `PAYMENT_GATEWAY` | `zarinpal` | درگاه: zarinpal, perfect_money |
| `ZARINPAL_MERCHANT` | `your_merchant_id` | Merchant ID زرین‌پال |

### گام 3.3: ذخیره‌سازی

بعد از اضافه کردن تمام متغیرها، صفحه خودکار ذخیره می‌شود.

---

## مرحله 4: راه‌اندازی

### گام 4.1: بررسی ساخت

1. روی **Deployments** تب کلیک کنید
2. وضعیت ساخت را ببینید:
   - 🟢 **Success** - کامل شد
   - 🔵 **Building** - درحال ساخت
   - 🔴 **Failed** - ناموفق

### گام 4.2: دریافت دامنه

وقتی ساخت موفق شد:
1. روی **Deployments** کلیک کنید
2. **Domain** را کپی کنید (مثال: `my-bot-abc123.railway.app`)
3. این دامنه را در متغیر `BOT_DOMAIN` و `WEBHOOK_URL` قرار دهید

---

## مرحله 5: تنظیمات Webhook

### گام 5.1: فهم Webhook

Webhook روشی است که تلگرام از طریق آن پیام‌ها را به ربات می‌فرستد.

### گام 5.2: تنظیم Webhook

فایل PHP ایجاد کنید یا از مرحله entrypoint استفاده کنید:

```bash
# دستور تنظیم webhook
https://api.telegram.org/bot{BOT_TOKEN}/setWebhook?url={WEBHOOK_URL}&secret_token={WEBHOOK_SECRET}
```

**جایگزین کنید:**
- `{BOT_TOKEN}` = توکن ربات
- `{WEBHOOK_URL}` = `https://your-domain.railway.app/webhook`
- `{WEBHOOK_SECRET}` = کلید محرمانه

**مثال واقعی:**
```
https://api.telegram.org/bot123456:ABC-DEF/setWebhook?url=https://my-bot.railway.app/webhook&secret_token=my_secret_key_123
```

### گام 5.3: اجرا

این لینک را در مرورگر باز کنید. اگر `"ok":true` دریافت کردید، موفق بود!

---

## مشکل‌یابی و راه‌حل‌ها

### ❌ خطای: "Build failed"

**علت:** فایل Dockerfile یا entrypoint.sh مشکل دارد

**حل:**
1. **Logs** تب را کلیک کنید
2. پیام خطا را بخوانید
3. اطمینان دهید تمام فایل‌ها صحیح هستند
4. دوباره **Deploy** کنید

### ❌ خطای: "502 Bad Gateway"

**علت:** سرویس‌ها درست شروع نشده‌اند

**حل:**
1. صبر کنید 30-60 ثانیه
2. صفحه را رفرش کنید
3. **Logs** را بررسی کنید

### ❌ ربات جواب نمی‌دهد

**احتمالات:**
- BOT_TOKEN اشتباه است
- Webhook درست تنظیم نشده است
- دیتابیس متصل نیست

**حل:**
1. **Logs** در Railway را بررسی کنید
2. متغیرهای محیط‌ایی را دوباره‌چک کنید
3. webhook را دوباره تنظیم کنید

### ❌ "Unauthorized" خطا

**علت:** توکن نادرست یا منقضی است

**حل:**
1. توکن جدید از BotFather بگیرید
2. متغیر `BOT_TOKEN` را به‌روزرسانی کنید
3. دوباره Deploy کنید

---

## 🔧 دستورات مفید

### بررسی Logs
```bash
# در خط فرمان Railway CLI
railway logs
```

### متصل شدن به دیتابیس
```bash
# دستور اتصال
mysql -h localhost -u root -p mirzaprobot
```

### دوباره‌شروع خدمات
```bash
# دوباره Deploy
railway redeploy
```

---

## ✅ تکمیل‌شدگی بررسی

بعد از تمام مراحل، این موارد را بررسی کنید:

- [ ] ربات توکن دارد و در BotFather تأیید شده
- [ ] شناسه ادمین صحیح است
- [ ] تمام متغیرهای محیط‌ایی تنظیم شده‌اند
- [ ] Webhook تنظیم شده است
- [ ] ربات در تلگرام جواب می‌دهد
- [ ] لاگ‌ها خطا نشان نمی‌دهند

---

## 📞 پشتیبانی و کمک

### اگر مشکل دارید:

1. **Logs را بررسی کنید** - بیشتر مشکل‌ها در logs نوشته‌شده‌اند
2. **متغیرهای محیط‌ایی را دوباره‌بررسی کنید**
3. **Webhook URL صحیح است** - `https://your-domain.railway.app/webhook`
4. **توکن نادرست نیست** - از BotFather کپی کنید

---

## 🎉 تبریک!

اگر تا اینجا رسیدید، Mirza Pro شما روی Railway فعال است! 🚀

**نکات مهم:**
- رمز دیتابیس را در جایی امن ذخیره کنید
- Logs را به‌طور منظم بررسی کنید
- پایگاه داده خود را backup کنید

**موفق باشید!** 🎊
