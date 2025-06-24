<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Content-Type: application/json");
require_once '../config/db_connect.php';

$sql = "SELECT MaSanPham, TenSanPham, Mota, Gia, SoLuongTonKho,TrangThai,MauSac,KichCo,HinhAnh  FROM sanpham";
$result = $conn->query($sql);

$products = [];
while ($row = $result->fetch_assoc()) {
    $products[] = $row;
}

echo json_encode(["success" => 200, "data" => $products]);
?>