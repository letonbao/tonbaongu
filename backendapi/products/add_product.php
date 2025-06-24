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

if (!empty($data['TenSanPham']) && !empty($data['Gia'])) {
    $ten = $data['TenSanPham'];
    $mota = $data['Mota'] ?? '';
    $gia = $data['Gia'];
    $soluong = $data['SoLuongTonKho'] ?? 0;
    $trangthai = $data['TrangThai'] ?? '';
    $mausac = $data['MauSac'] ?? '';
    $kichco = $data['KichCo'] ?? '';
    $hinhanh = $data['HinhAnh'] ?? '';

    $stmt = $conn->prepare("INSERT INTO sanpham (TenSanPham, Mota, Gia, SoLuongTonKho, TrangThai, MauSac, KichCo, HinhAnh) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
    $stmt->bind_param("ssdissss", $ten, $mota, $gia, $soluong, $trangthai, $mausac, $kichco, $hinhanh);

    if ($stmt->execute()) {
        echo json_encode(["success" => true, "message" => "Thêm sản phẩm thành công"]);
    } else {
        echo json_encode(["success" => false, "message" => "Lỗi: " . $conn->error]);
    }
    $stmt->close();
} else {
    echo json_encode(["success" => false, "message" => "Thiếu dữ liệu"]);
}
?> 