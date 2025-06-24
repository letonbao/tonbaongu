<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

// Nhúng file kết nối CSDL
require_once '../config/db_connect.php';

$sql = "SELECT MaDH, MaND, NgayDatHang, TongGiaTri, TrangThaiDonHang FROM donhang";
$result = $conn->query($sql);

$orders = [];
if ($result && $result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $orders[] = $row;
    }
    echo json_encode(["success" => true, "data" => $orders]);
} else {
    echo json_encode(["success" => false, "message" => "Không có đơn hàng nào"]);
}

$conn->close();
?>
