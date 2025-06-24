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

if (!empty($data['MaDH'])) {
    $maDH = $data['MaDH'];
    $maND = $data['MaND'];
    $ngayDatHang = $data['NgayDatHang'];
    $tongGiaTri = $data['TongGiaTri'];
    $trangThai = $data['TrangThaiDonHang'];

    $stmt = $conn->prepare("UPDATE donhang SET MaND=?, NgayDatHang=?, TongGiaTri=?, TrangThaiDonHang=? WHERE MaDH=?");
    $stmt->bind_param("isdsi", $maND, $ngayDatHang, $tongGiaTri, $trangThai, $maDH);

    if ($stmt->execute()) {
        echo json_encode(["success" => true, "message" => "Cập nhật thành công"]);
    } else {
        echo json_encode(["success" => false, "message" => "Lỗi: " . $conn->error]);
    }
    $stmt->close();
} else {
    echo json_encode(["success" => false, "message" => "Thiếu MaDH"]);
}
?> 