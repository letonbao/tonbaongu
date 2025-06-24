<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    http_response_code(200);
    exit();
}

require_once '../config/db_connect.php';

$data = json_decode(file_get_contents("php://input"), true);
$maDH = $data['MaDH'] ?? null;

if ($maDH) {
    $stmt = $conn->prepare("DELETE FROM donhang WHERE MaDH=?");
    $stmt->bind_param("i", $maDH);

    if ($stmt->execute()) {
        echo json_encode(["success" => true, "message" => "Xóa thành công"]);
    } else {
        echo json_encode(["success" => false, "message" => "Lỗi: " . $conn->error]);
    }
    $stmt->close();
} else {
    echo json_encode(["success" => false, "message" => "Thiếu MaDH"]);
}
?> 