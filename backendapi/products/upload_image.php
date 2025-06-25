<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Content-Type: application/json");

$target_dir = "../../assets/images/";
if (!file_exists($target_dir)) {
    mkdir($target_dir, 0777, true);
}

if (isset($_FILES["file"])) {
    $file = $_FILES["file"];
    $target_file = $target_dir . basename($file["name"]);
    if (move_uploaded_file($file["tmp_name"], $target_file)) {
        $url = "assets/images/" . basename($file["name"]);
        echo json_encode(["success" => 1, "url" => $url]);
    } else {
        echo json_encode(["success" => 0, "message" => "Upload failed"]);
    }
} else {
    echo json_encode(["success" => 0, "message" => "No file uploaded"]);
}
?> 