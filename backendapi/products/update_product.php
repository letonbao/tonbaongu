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

if (!empty($data['MaSanPham'])) {
    $maSP = $data['MaSanPham'];
    $ten = $data['TenSanPham'];
    $mota = $data['Mota'];
    $gia = $data['Gia'];
    $soluong = $data['SoLuongTonKho'];
    $trangthai = $data['TrangThai'];
    $mausac = $data['MauSac'];
    $kichco = $data['KichCo'];
    $hinhanh = $data['HinhAnh'];

    $stmt = $conn->prepare("UPDATE sanpham SET TenSanPham=?, Mota=?, Gia=?, SoLuongTonKho=?, TrangThai=?, MauSac=?, KichCo=?, HinhAnh=? WHERE MaSanPham=?");
    $stmt->bind_param("ssdissssi", $ten, $mota, $gia, $soluong, $trangthai, $mausac, $kichco, $hinhanh, $maSP);

    if ($stmt->execute()) {
        echo json_encode(["success" => true, "message" => "Cập nhật thành công"]);
    } else {
        echo json_encode(["success" => false, "message" => "Lỗi: " . $conn->error]);
    }
    $stmt->close();
} else {
    echo json_encode(["success" => false, "message" => "Thiếu MaSanPham"]);
}
?> 