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

if (!empty($data['name'])) {
    $name = $data['name'];
    $description = $data['description'] ?? '';
    $category = $data['category'] ?? 'T-Shirts';
    $gender_target = $data['gender_target'] ?? 'unisex';
    
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

    // Insert into products table
    $stmt = $conn->prepare("INSERT INTO products (name, description, category, gender_target) VALUES (?, ?, ?, ?)");
    $stmt->bind_param("ssss", $name, $description, $category, $gender_target);
    
    if ($stmt->execute()) {
        $product_id = $conn->insert_id;
        echo json_encode([
            "success" => true, 
            "message" => "Thêm sản phẩm thành công",
            "product_id" => $product_id
        ]);
    } else {
        echo json_encode(["success" => false, "message" => "Lỗi: " . $conn->error]);
    }
    
    $stmt->close();
    
} else {
    echo json_encode(["success" => false, "message" => "Thiếu tên sản phẩm"]);
}

$conn->close();
?> 