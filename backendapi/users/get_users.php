<?php
header("Access-Control-Allow-Origin: *");
header('Content-Type: application/json');
require_once '../config/db_connect.php';

$sql = "SELECT MaND, Ten, MatKhau, SoDienThoai, Email, Role FROM nguoidung";  
$result = $conn->query($sql);

$users = [];
while ($row = $result->fetch_assoc()) {
    $users[] = $row;
}

echo json_encode(["success" => 200 , "data" => $users]);
?>
