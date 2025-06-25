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

// Nhận dữ liệu từ form multipart/form-data
$ten = $_POST['TenSanPham'] ?? '';
$mota = $_POST['Mota'] ?? '';
$gia = $_POST['Gia'] ?? '';
$soluong = $_POST['SoLuongTonKho'] ?? 0;
$trangthai = $_POST['TrangThai'] ?? '';
$mausac = $_POST['MauSac'] ?? '';
$kichco = $_POST['KichCo'] ?? '';
$hinhanh = '';

// Xử lý upload file hình ảnh nếu có
if (isset($_FILES['HinhAnh']) && $_FILES['HinhAnh']['error'] == UPLOAD_ERR_OK) {
    $target_dir = '../../assets/images/';
    if (!file_exists($target_dir)) {
        mkdir($target_dir, 0777, true);
    }
    $file_name = basename($_FILES['HinhAnh']['name']);
    $target_file = $target_dir . $file_name;
    if (move_uploaded_file($_FILES['HinhAnh']['tmp_name'], $target_file)) {
        $hinhanh = 'assets/images/' . $file_name;
    }
}

if (!empty($ten) && !empty($gia)) {
    $stmt = $conn->prepare("INSERT INTO sanpham (TenSanPham, Mota, Gia, SoLuongTonKho, TrangThai, MauSac, KichCo, HinhAnh) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
    $stmt->bind_param("ssdissss", $ten, $mota, $gia, $soluong, $trangthai, $mausac, $kichco, $hinhanh);

    if ($stmt->execute()) {
        echo json_encode(["success" => 200, "message" => "Thêm sản phẩm thành công"]); 
    } else {
        echo json_encode(["success" => 400, "message" => "Lỗi: " . $conn->error]); 
    }
    $stmt->close();
} else {
    echo json_encode(["success" => 400, "message" => "Thiếu dữ liệu"]); 
}
?> 