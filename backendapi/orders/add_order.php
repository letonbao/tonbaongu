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

if (!empty($data['MaND']) && !empty($data['TongGiaTri'])) {
    $maND = $data['MaND'];
    $ngayDatHang = $data['NgayDatHang'] ?? date('Y-m-d');
    $tongGiaTri = $data['TongGiaTri'];
    $trangThai = $data['TrangThaiDonHang'] ?? 'Đang xử lý';

    $stmt = $conn->prepare("INSERT INTO donhang (MaND, NgayDatHang, TongGiaTri, TrangThaiDonHang) VALUES (?, ?, ?, ?)");
    $stmt->bind_param("isds", $maND, $ngayDatHang, $tongGiaTri, $trangThai);

    if ($stmt->execute()) {
        echo json_encode(["success" => true, "message" => "Thêm đơn hàng thành công"]);
    } else {
        echo json_encode(["success" => false, "message" => "Lỗi: " . $conn->error]);
    }
    $stmt->close();
} else {
    echo json_encode(["success" => false, "message" => "Thiếu dữ liệu"]);
}
?> 