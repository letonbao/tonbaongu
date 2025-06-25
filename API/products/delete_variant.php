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
$variant_id = $data['variant_id'] ?? null;

if ($variant_id) {
    // Check if variant exists
    $check_stmt = $conn->prepare("SELECT id, product_id FROM product_variants WHERE id = ?");
    $check_stmt->bind_param("i", $variant_id);
    $check_stmt->execute();
    $result = $check_stmt->get_result();
    
    if ($result->num_rows === 0) {
        echo json_encode(["success" => false, "message" => "Biến thể không tồn tại"]);
        $check_stmt->close();
        exit();
    }
    
    $variant_data = $result->fetch_assoc();
    $product_id = $variant_data['product_id'];
    $check_stmt->close();
    
    // Check if this variant is used in any orders
    $order_check_stmt = $conn->prepare("SELECT id FROM order_items WHERE product_variant_id = ?");
    $order_check_stmt->bind_param("i", $variant_id);
    $order_check_stmt->execute();
    $order_result = $order_check_stmt->get_result();
    
    if ($order_result->num_rows > 0) {
        echo json_encode(["success" => false, "message" => "Không thể xóa biến thể đã được sử dụng trong đơn hàng"]);
        $order_check_stmt->close();
        exit();
    }
    $order_check_stmt->close();
    
    // Check if this variant is in any cart
    $cart_check_stmt = $conn->prepare("SELECT id FROM cart_items WHERE product_variant_id = ?");
    $cart_check_stmt->bind_param("i", $variant_id);
    $cart_check_stmt->execute();
    $cart_result = $cart_check_stmt->get_result();
    
    if ($cart_result->num_rows > 0) {
        echo json_encode(["success" => false, "message" => "Không thể xóa biến thể đang có trong giỏ hàng"]);
        $cart_check_stmt->close();
        exit();
    }
    $cart_check_stmt->close();
    
    // Delete variant
    $stmt = $conn->prepare("DELETE FROM product_variants WHERE id = ?");
    $stmt->bind_param("i", $variant_id);
    
    if ($stmt->execute()) {
        echo json_encode([
            "success" => true, 
            "message" => "Xóa biến thể thành công",
            "variant_id" => $variant_id,
            "product_id" => $product_id
        ]);
    } else {
        echo json_encode(["success" => false, "message" => "Lỗi: " . $conn->error]);
    }
    
    $stmt->close();
    
} else {
    echo json_encode(["success" => false, "message" => "Thiếu variant_id"]);
}

$conn->close();
?>
