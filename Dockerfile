# استفاده از تصویر PHP با Apache (نسخه بهینه و پایدار)
FROM php:8.2-apache

# تنظیم timezone و locale
ENV TZ=Asia/Tehran \
    DEBIAN_FRONTEND=noninteractive

# نصب وابستگی‌های سیستم (پکیج‌های قدیمی + extensions)
RUN apt-get update && apt-get install -y --no-install-recommends \
    mariadb-server \
    mariadb-client \
    wget \
    curl \
    git \
    unzip \
    vim \
    nano \
    cron \
    supervisor \
    openssh-server \
    libzip-dev \
    php-mysql \
    php-curl \
    php-gd \
    php-mbstring \
    php-xml \
    php-json \
    php-bcmath \
    php-intl \
    ca-certificates \
    tzdata \
    && rm -rf /var/lib/apt/lists/*

# نصب و فعال کردن PHP Extensions
RUN docker-php-ext-install \
    pdo \
    pdo_mysql \
    mysqli \
    zip \
    gd \
    curl \
    mbstring \
    xml \
    json \
    bcmath \
    intl

# فعال کردن mod_rewrite برای Apache
RUN a2enmod rewrite && \
    a2enmod ssl && \
    a2enmod headers && \
    a2enmod http2

# ایجاد دایرکتوری برای Bot
RUN mkdir -p /var/www/html/mirzaprobotconfig && \
    mkdir -p /var/lib/mysql && \
    mkdir -p /var/log/supervisor && \
    mkdir -p /run/mysqld

# تنظیم مجوزهای دایرکتوری
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html && \
    chown -R mysql:mysql /var/lib/mysql && \
    chown -R mysql:mysql /run/mysqld

# کپی کردن فایل کانفیگ Apache
COPY apache.conf /etc/apache2/sites-available/000-default.conf
RUN a2ensite 000-default

# کپی کردن فایل کانفیگ PHP
RUN echo "upload_max_filesize = 100M" >> /usr/local/etc/php/conf.d/uploads.ini && \
    echo "post_max_size = 100M" >> /usr/local/etc/php/conf.d/uploads.ini && \
    echo "max_execution_time = 300" >> /usr/local/etc/php/conf.d/uploads.ini && \
    echo "memory_limit = 512M" >> /usr/local/etc/php/conf.d/uploads.ini

# کپی کردن فایل کانفیگ Supervisor
COPY supervisor.conf /etc/supervisor/conf.d/supervisor.conf

# کپی کردن اسکریپت ورودی
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# کپی کردن فایل تنظیم Webhook
COPY setup-webhook.php /var/www/html/setup-webhook.php
COPY health.php /var/www/html/health.php
RUN chown www-data:www-data /var/www/html/*.php && \
    chmod 644 /var/www/html/*.php

# افشاء کردن درگاه‌ها
EXPOSE 80 443 3306

# دستور شروع
CMD ["/usr/local/bin/entrypoint.sh"]
