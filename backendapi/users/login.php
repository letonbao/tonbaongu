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

if (!empty($data['Email']) && !empty($data['MatKhau'])) {
    $email = $data['Email'];
    $matkhau = $data['MatKhau'];

    $stmt = $conn->prepare("SELECT MaND, Ten, Email, SoDienThoai FROM nguoidung WHERE Email = ? AND MatKhau = ?");
    $stmt->bind_param("ss", $email, $matkhau);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $user = $result->fetch_assoc();
        echo json_encode([
            "success" => 200, 
            "message" => "Đăng nhập thành công",
            "user" => $user
        ]);
    } else {
        echo json_encode([
            "success" => 404, 
            "message" => "Email hoặc mật khẩu không đúng"
        ]);
    }
    $stmt->close();
} else {
    echo json_encode([
        "success" => 500, 
        "message" => "Vui lòng nhập đầy đủ thông tin"
    ]);
}
?> 