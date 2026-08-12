<?php
/**
 * فایل بررسی سلامت Mirza Pro
 * استفاده برای Docker health check
 */

header('Content-Type: application/json');

$health = array(
    'status' => 'healthy',
    'timestamp' => date('Y-m-d H:i:s'),
    'services' => array()
);

$all_healthy = true;

// 1. بررسی PHP
$health['services']['php'] = array(
    'status' => 'ok',
    'version' => phpversion()
);

// 2. بررسی دیتابیس
$db_host = getenv('DB_HOST') ?: 'localhost';
$db_name = getenv('DB_NAME') ?: 'mirzaprobot';
$db_user = getenv('DB_USER') ?: 'root';
$db_password = getenv('DB_PASSWORD') ?: 'mirzapro_secure_2024';

try {
    $pdo = new PDO(
        "mysql:host=$db_host;dbname=$db_name;charset=utf8mb4",
        $db_user,
        $db_password,
        array(PDO::ATTR_TIMEOUT => 5)
    );
    
    $result = $pdo->query('SELECT 1');
    
    if ($result) {
        $health['services']['database'] = array(
            'status' => 'ok',
            'host' => $db_host,
            'database' => $db_name
        );
    } else {
        $health['services']['database'] = array(
            'status' => 'error',
            'message' => 'Query failed'
        );
        $all_healthy = false;
    }
} catch (Exception $e) {
    $health['services']['database'] = array(
        'status' => 'error',
        'message' => $e->getMessage()
    );
    $all_healthy = false;
}

// 3. بررسی فایل‌های ضروری
$required_files = array(
    '/var/www/html/mirzaprobotconfig/index.php',
    '/var/www/html/mirzaprobotconfig/config.php'
);

$files_status = 'ok';
$missing_files = array();

foreach ($required_files as $file) {
    if (!file_exists($file)) {
        $missing_files[] = $file;
        $files_status = 'missing';
        $all_healthy = false;
    }
}

$health['services']['files'] = array(
    'status' => $files_status,
    'missing' => $missing_files
);

// 4. بررسی موارد قابل دسترسی
$directories = array(
    '/var/www/html/mirzaprobotconfig/uploads',
    '/var/www/html/mirzaprobotconfig/storage',
    '/var/www/html/mirzaprobotconfig/logs'
);

$dir_status = 'ok';
$missing_dirs = array();

foreach ($directories as $dir) {
    if (!is_writable($dir) && !is_dir($dir)) {
        $missing_dirs[] = $dir;
        $dir_status = 'missing';
        $all_healthy = false;
    }
}

$health['services']['directories'] = array(
    'status' => $dir_status,
    'missing' => $missing_dirs
);

// 5. بررسی Apache/Web Server
$health['services']['webserver'] = array(
    'status' => 'ok',
    'server' => $_SERVER['SERVER_SOFTWARE'] ?? 'Unknown'
);

// وضعیت نهایی
$health['status'] = $all_healthy ? 'healthy' : 'unhealthy';

// تنظیم کد وضعیت HTTP
http_response_code($all_healthy ? 200 : 503);

// خروجی JSON
echo json_encode($health, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES);
?>
