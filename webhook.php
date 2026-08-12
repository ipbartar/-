<?php
/**
 * Webhook برای دریافت پیام‌های Telegram
 * آدرس: https://domain.railway.app/webhook
 */

// تنظیم Header
header('Content-Type: application/json');

// دریافت درخواست
$input = file_get_contents('php://input');
$data = json_decode($input, true);

// بررسی Secret Token (امنیتی)
$webhook_secret = getenv('WEBHOOK_SECRET');
$header_secret = $_SERVER['HTTP_X_TELEGRAM_BOT_API_SECRET_TOKEN'] ?? null;

// لاگ کردن
$log_dir = '/var/www/html/mirzaprobotconfig/logs';
if (!is_dir($log_dir)) {
    mkdir($log_dir, 0755, true);
}

$log_file = $log_dir . '/webhook_' . date('Y-m-d') . '.log';

// بررسی Secret
if ($webhook_secret && $header_secret !== $webhook_secret) {
    error_log('[' . date('Y-m-d H:i:s') . '] ❌ Unauthorized: Invalid secret token', 3, $log_file);
    http_response_code(401);
    echo json_encode(['error' => 'Unauthorized']);
    exit;
}

// بررسی داده‌های خالی
if (empty($data)) {
    http_response_code(400);
    echo json_encode(['error' => 'Empty data']);
    exit;
}

// لاگ کردن درخواست
error_log('[' . date('Y-m-d H:i:s') . '] 📨 Incoming webhook: ' . substr(json_encode($data), 0, 200), 3, $log_file);

// بررسی نوع پیام
if (isset($data['message'])) {
    $message = $data['message'];
    $chat_id = $message['chat']['id'];
    $from_id = $message['from']['id'];
    $text = $message['text'] ?? '';
    
    // ذخیره‌سازی پیام در دیتابیس (اگر نیاز است)
    // می‌توانید اینجا پردازش اضافی انجام دهید
    
    error_log('[' . date('Y-m-d H:i:s') . '] ✉️ Message from ' . $from_id . ': ' . substr($text, 0, 100), 3, $log_file);
    
} elseif (isset($data['callback_query'])) {
    $callback = $data['callback_query'];
    error_log('[' . date('Y-m-d H:i:s') . '] 🔘 Callback from ' . $callback['from']['id'] . ': ' . $callback['data'], 3, $log_file);
    
} elseif (isset($data['pre_checkout_query'])) {
    error_log('[' . date('Y-m-d H:i:s') . '] 💳 Pre-checkout query received', 3, $log_file);
    
} elseif (isset($data['successful_payment'])) {
    error_log('[' . date('Y-m-d H:i:s') . '] ✅ Payment successful', 3, $log_file);
    
} else {
    error_log('[' . date('Y-m-d H:i:s') . '] ⚠️ Unknown update type', 3, $log_file);
}

// پاسخ OK (Telegram نیاز دارد)
http_response_code(200);
echo json_encode(['ok' => true]);
?>
