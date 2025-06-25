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

if (!empty($data['product_id'])) {
    $product_id = $data['product_id'];
    $color = $data['color'] ?? 'black';
    $size = $data['size'] ?? 'M';
    $material = $data['material'] ?? 'Cotton';
    $style = $data['style'] ?? '';
    $price = $data['price'] ?? 0;
    $stock = $data['stock'] ?? 0;
    $image_url = $data['image_url'] ?? '';
    $status = $data['status'] ?? 'active';
    
    // Validate product_id exists
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
    
    // Validate color
    $valid_colors = ['white','black','purple','pink','blue','silver','red','yellow','green','brown','gray','orange'];
    if (!in_array($color, $valid_colors)) {
        echo json_encode(["success" => false, "message" => "Màu sắc không hợp lệ"]);
        exit();
    }
    
    // Validate size
    $valid_sizes = ['S','M','L','XL','XXL','XXXL'];
    if (!in_array($size, $valid_sizes)) {
        echo json_encode(["success" => false, "message" => "Kích thước không hợp lệ"]);
        exit();
    }
    
    // Validate material
    $valid_materials = ['Cotton','Linen','Wool','Polyester','Denim','Leather','Silk','Nylon'];
    if (!in_array($material, $valid_materials)) {
        echo json_encode(["success" => false, "message" => "Chất liệu không hợp lệ"]);
        exit();
    }
    
    // Validate status
    $valid_statuses = ['active','inactive','out_of_stock'];
    if (!in_array($status, $valid_statuses)) {
        echo json_encode(["success" => false, "message" => "Trạng thái không hợp lệ"]);
        exit();
    }
    
    // If style is not provided, get it from the product
    if (empty($style)) {
        $style_stmt = $conn->prepare("SELECT category FROM products WHERE id = ?");
        $style_stmt->bind_param("i", $product_id);
        $style_stmt->execute();
        $style_result = $style_stmt->get_result();
        $product_data = $style_result->fetch_assoc();
        $style = $product_data['category'];
        $style_stmt->close();
    }
    
    // Check if variant already exists
    $duplicate_stmt = $conn->prepare("SELECT id FROM product_variants WHERE product_id = ? AND color = ? AND size = ?");
    $duplicate_stmt->bind_param("iss", $product_id, $color, $size);
    $duplicate_stmt->execute();
    $duplicate_result = $duplicate_stmt->get_result();
    
    if ($duplicate_result->num_rows > 0) {
        echo json_encode(["success" => false, "message" => "Biến thể này đã tồn tại"]);
        $duplicate_stmt->close();
        exit();
    }
    $duplicate_stmt->close();

    // Insert variant
    $stmt = $conn->prepare("INSERT INTO product_variants (product_id, color, size, material, style, price, stock, image_url, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
    $stmt->bind_param("issssdiss", $product_id, $color, $size, $material, $style, $price, $stock, $image_url, $status);
    
    if ($stmt->execute()) {
        $variant_id = $conn->insert_id;
        echo json_encode([
            "success" => true, 
            "message" => "Thêm biến thể sản phẩm thành công",
            "variant_id" => $variant_id,
            "product_id" => $product_id
        ]);
    } else {
        echo json_encode(["success" => false, "message" => "Lỗi: " . $conn->error]);
    }
    
    $stmt->close();
    
} else {
    echo json_encode(["success" => false, "message" => "Thiếu product_id"]);
}

$conn->close();
?>
