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

if (!empty($data['id'])) {
    $product_id = $data['id'];
    $name = $data['name'] ?? '';
    $description = $data['description'] ?? '';
    $category = $data['category'] ?? 'T-Shirts';
    $gender_target = $data['gender_target'] ?? 'unisex';
    
    // Check if product exists
    $check_stmt = $conn->prepare("SELECT id FROM products WHERE id = ?");
    $check_stmt->bind_param("i", $product_id);
    $check_stmt->execute();
    $result = $check_stmt->get_result();
    
    if ($result->num_rows === 0) {
        echo json_encode(["success" => false, "message" => "Sản phẩm không tồn tại"]);
        $check_stmt->close();
        exit();
    }
    $check_stmt->close();
    
    // Validate category
    $valid_categories = ['T-Shirts','Shirts','Jackets & Coats','Pants','Shorts','Knitwear','Suits & Blazers','Hoodies','Underwear','Loungewear'];
    if (!in_array($category, $valid_categories)) {
        echo json_encode(["success" => false, "message" => "Danh mục không hợp lệ"]);
        exit();
    }
    
    // Validate gender_target
    $valid_genders = ['male','female','kids','unisex'];
    if (!in_array($gender_target, $valid_genders)) {
        echo json_encode(["success" => false, "message" => "Đối tượng giới tính không hợp lệ"]);
        exit();
    }

    $stmt = $conn->prepare("UPDATE products SET name = ?, description = ?, category = ?, gender_target = ? WHERE id = ?");
    $stmt->bind_param("ssssi", $name, $description, $category, $gender_target, $product_id);

    if ($stmt->execute()) {
        echo json_encode(["success" => true, "message" => "Cập nhật sản phẩm thành công"]);
    } else {
        echo json_encode(["success" => false, "message" => "Lỗi: " . $conn->error]);
    }
    $stmt->close();
} else {
    echo json_encode(["success" => false, "message" => "Thiếu ID sản phẩm"]);
}

$conn->close();
?> 