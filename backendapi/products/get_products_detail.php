<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Content-Type: application/json");
require_once '../config/db_connect.php';

$sql = "SELECT MaSanPham,MauSac,KichCo,Gia,SoLuongTonKho  FROM phienbansanpham";
$result = $conn->query($sql);

$products_detail = [];
while ($row = $result->fetch_assoc()) {
    $products_detail[] = $row;
}

echo json_encode(["success" => 200, "data" => $products_detail]);
?>