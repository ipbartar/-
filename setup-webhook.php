<?php
/**
 * تنظیم خودکار Webhook برای Telegram
 * این فایل خودکار webhook را تنظیم می‌کند
 * آدرس: https://domain.railway.app/setup-webhook.php
 */

header('Content-Type: application/json; charset=utf-8');

// تشخیص دامنه خودکار
$domain = $_SERVER['HTTP_HOST'] ?? getenv('BOT_DOMAIN') ?? 'localhost';
$protocol = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? 'https' : 'http';

// ساخت URL
$webhook_url = $protocol . '://' . $domain . '/webhook';
$webhook_secret = getenv('WEBHOOK_SECRET') ?: 'your_webhook_secret';
$bot_token = getenv('BOT_TOKEN');

// بررسی‌های اولیه
$errors = [];
$info = [];

if (!$bot_token) {
    $errors[] = "❌ BOT_TOKEN تنظیم نشده است!";
} else {
    $info[] = "✅ BOT_TOKEN: " . substr($bot_token, 0, 10) . "...";
}

// اگر درخواست POST برای تنظیم Webhook
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    
    if ($errors) {
        http_response_code(400);
        echo json_encode([
            'status' => 'error',
            'message' => 'پیش‌نیازهای نیاز برای تنظیم نیست',
            'errors' => $errors
        ]);
        exit;
    }

    // آدرس Telegram API
    $telegram_api = "https://api.telegram.org/bot{$bot_token}/setWebhook";
    
    // پارامتر‌ها
    $params = [
        'url' => $webhook_url,
        'secret_token' => $webhook_secret,
        'max_connections' => 40,
        'allowed_updates' => ['message', 'callback_query', 'pre_checkout_query', 'successful_payment']
    ];

    // درخواست cURL
    $ch = curl_init();
    curl_setopt_array($ch, [
        CURLOPT_URL => $telegram_api,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_POST => true,
        CURLOPT_POSTFIELDS => http_build_query($params),
        CURLOPT_TIMEOUT => 10,
        CURLOPT_SSL_VERIFYPEER => true,
        CURLOPT_HTTPHEADER => [
            'Content-Type: application/x-www-form-urlencoded'
        ]
    ]);

    $response = curl_exec($ch);
    $http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $curl_error = curl_error($ch);
    curl_close($ch);

    // بررسی پاسخ
    if ($curl_error) {
        http_response_code(500);
        echo json_encode([
            'status' => 'error',
            'message' => 'خطا در اتصال به Telegram API',
            'error' => $curl_error,
            'webhook_url' => $webhook_url
        ]);
        exit;
    }

    $telegram_response = json_decode($response, true);

    if ($telegram_response && $telegram_response['ok'] === true) {
        http_response_code(200);
        echo json_encode([
            'status' => 'success',
            'message' => '✅ Webhook با موفقیت تنظیم شد!',
            'webhook_url' => $webhook_url,
            'details' => $telegram_response['result'] ?? 'تنظیم انجام شد'
        ]);
    } else {
        http_response_code(400);
        echo json_encode([
            'status' => 'error',
            'message' => '❌ خطا در تنظیم Webhook',
            'error' => $telegram_response['description'] ?? 'خطای نامشخص',
            'webhook_url' => $webhook_url,
            'telegram_response' => $telegram_response
        ]);
    }
    exit;
}

// اگر درخواست GET یا بررسی وضعیت
if ($_SERVER['REQUEST_METHOD'] === 'GET' || $_GET['action'] === 'check') {
    
    $telegram_api = "https://api.telegram.org/bot{$bot_token}/getWebhookInfo";
    
    $ch = curl_init();
    curl_setopt_array($ch, [
        CURLOPT_URL => $telegram_api,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_TIMEOUT => 10,
        CURLOPT_SSL_VERIFYPEER => true
    ]);

    $response = curl_exec($ch);
    $http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $curl_error = curl_error($ch);
    curl_close($ch);

    if ($curl_error) {
        http_response_code(500);
        echo json_encode([
            'status' => 'error',
            'message' => 'خطا در اتصال به Telegram',
            'error' => $curl_error
        ]);
        exit;
    }

    $webhook_info = json_decode($response, true);
    
    if ($webhook_info['ok'] === true) {
        $current = $webhook_info['result'];
        
        http_response_code(200);
        echo json_encode([
            'status' => 'success',
            'message' => '📊 وضعیت Webhook',
            'current_webhook' => $current['url'] ?? 'تنظیم‌نشده',
            'pending_updates' => $current['pending_update_count'] ?? 0,
            'recommended_webhook' => $webhook_url,
            'match' => ($current['url'] ?? '') === $webhook_url ? '✅ تطابق دارد' : '⚠️ تطابق ندارد',
            'needs_setup' => ($current['url'] ?? '') !== $webhook_url,
            'info' => $info
        ]);
    } else {
        http_response_code(400);
        echo json_encode([
            'status' => 'error',
            'message' => 'خطا در دریافت اطلاعات',
            'error' => $webhook_info['description'] ?? 'نامشخص'
        ]);
    }
    exit;
}

// درخواست‌های دیگر
http_response_code(400);
echo json_encode([
    'status' => 'error',
    'message' => 'درخواست نامعتبر',
    'usage' => [
        'بررسی وضعیت' => 'GET /setup-webhook.php?action=check',
        'تنظیم Webhook' => 'POST /setup-webhook.php'
    ],
    'info' => $info,
    'detected_domain' => $domain,
    'detected_protocol' => $protocol
]);
?>
