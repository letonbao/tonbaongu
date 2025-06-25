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

if (!empty($data['variant_id'])) {
    $variant_id = $data['variant_id'];
    $color = $data['color'] ?? null;
    $size = $data['size'] ?? null;
    $material = $data['material'] ?? null;
    $price = $data['price'] ?? null;
    $stock = $data['stock'] ?? null;
    $image_url = $data['image_url'] ?? null;
    $status = $data['status'] ?? null;
    
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
    
    // Get current variant data to merge with updates
    $current_stmt = $conn->prepare("SELECT color, size, material, price, stock, image_url, status FROM product_variants WHERE id = ?");
    $current_stmt->bind_param("i", $variant_id);
    $current_stmt->execute();
    $current_result = $current_stmt->get_result();
    $current_data = $current_result->fetch_assoc();
    $current_stmt->close();
    
    // Use provided values or keep current values
    $color = $color ?? $current_data['color'];
    $size = $size ?? $current_data['size'];
    $material = $material ?? $current_data['material'];
    $price = $price ?? $current_data['price'];
    $stock = $stock ?? $current_data['stock'];
    $image_url = $image_url ?? $current_data['image_url'];
    $status = $status ?? $current_data['status'];
    
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
    
    // Check for duplicate variant (same product, color, size but different variant_id)
    $duplicate_stmt = $conn->prepare("SELECT id FROM product_variants WHERE product_id = ? AND color = ? AND size = ? AND id != ?");
    $duplicate_stmt->bind_param("issi", $product_id, $color, $size, $variant_id);
    $duplicate_stmt->execute();
    $duplicate_result = $duplicate_stmt->get_result();
    
    if ($duplicate_result->num_rows > 0) {
        echo json_encode(["success" => false, "message" => "Biến thể này đã tồn tại"]);
        $duplicate_stmt->close();
        exit();
    }
    $duplicate_stmt->close();
    
    // Update variant (không còn material)
    $stmt = $conn->prepare("UPDATE product_variants SET color = ?, size = ?, material = ?, price = ?, stock = ?, image_url = ?, status = ? WHERE id = ?");
    $stmt->bind_param("sssdis si", $color, $size, $material, $price, $stock, $image_url, $status, $variant_id);
    
    if ($stmt->execute()) {
        echo json_encode([
            "success" => true, 
            "message" => "Cập nhật biến thể thành công",
            "variant_id" => $variant_id,
            "product_id" => $product_id,
            "updated_data" => [
                "color" => $color,
                "size" => $size,
                "material" => $material,
                "price" => $price,
                "stock" => $stock,
                "image_url" => $image_url,
                "status" => $status
            ]
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
