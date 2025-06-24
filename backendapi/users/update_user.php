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

if (!empty($data['MaND'])) {
    $maND = $data['MaND'];
    $ten = $data['Ten'];
    $matkhau = $data['MatKhau'];
    $sdt = $data['SoDienThoai'];
    $email = $data['Email'];

    $stmt = $conn->prepare("UPDATE nguoidung SET Ten=?, MatKhau=?, SoDienThoai=?, Email=? WHERE MaND=?");
    $stmt->bind_param("ssssi", $ten, $matkhau, $sdt, $email, $maND);

    if ($stmt->execute()) {
        echo json_encode(["success" => true, "message" => "Cập nhật thành công"]);
    } else {
        echo json_encode(["success" => false, "message" => "Lỗi: " . $conn->error]);
    }
    $stmt->close();
} else {
    echo json_encode(["success" => false, "message" => "Thiếu MaND"]);
}
?> 