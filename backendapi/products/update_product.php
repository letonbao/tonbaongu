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
$maSP = $_POST['MaSanPham'] ?? '';
$ten = $_POST['TenSanPham'] ?? '';
$mota = $_POST['Mota'] ?? '';
$gia = $_POST['Gia'] ?? '';
$soluong = $_POST['SoLuongTonKho'] ?? 0;
$trangthai = $_POST['TrangThai'] ?? '';
$mausac = $_POST['MauSac'] ?? '';
$kichco = $_POST['KichCo'] ?? '';
$hinhanh = '';

// Lấy giá trị HinhAnh cũ nếu không upload file mới
if (!empty($maSP)) {
    $stmt_old = $conn->prepare("SELECT HinhAnh FROM sanpham WHERE MaSanPham=?");
    $stmt_old->bind_param("i", $maSP);
    $stmt_old->execute();
    $result = $stmt_old->get_result();
    if ($row = $result->fetch_assoc()) {
        $hinhanh = $row['HinhAnh'];
    }
    $stmt_old->close();
}

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

if (!empty($maSP)) {
    $stmt = $conn->prepare("UPDATE sanpham SET TenSanPham=?, Mota=?, Gia=?, SoLuongTonKho=?, TrangThai=?, MauSac=?, KichCo=?, HinhAnh=? WHERE MaSanPham=?");
    $stmt->bind_param("ssdissssi", $ten, $mota, $gia, $soluong, $trangthai, $mausac, $kichco, $hinhanh, $maSP);

    if ($stmt->execute()) {
        echo json_encode(["success" => 200, "message" => "Cập nhật thành công"]);
    } else {
        echo json_encode(["success" => 400, "message" => "Lỗi: " . $conn->error]);
    }
    $stmt->close();
} else {
    echo json_encode(["success" => 400, "message" => "Thiếu MaSanPham"]);
}
?> 