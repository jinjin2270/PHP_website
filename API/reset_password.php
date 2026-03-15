<?php
ini_set('display_errors', 1);
error_reporting(E_ALL);
header('Content-Type: application/json');

$host = "localhost";
$user = "root";
$pass = "";
$dbname = "foodfusion";

$conn = new mysqli($host, $user, $pass, $dbname);
if ($conn->connect_error) {
    echo json_encode(["error" => "Database connection failed."]);
    exit;
}

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $email = trim($_POST['email'] ?? '');
    $newPassword = trim($_POST['new_password'] ?? '');

    if (empty($email) || empty($newPassword)) {
        echo json_encode(["error" => "All fields are required."]);
        exit;
    }

    // Check if user exists
    $stmt = $conn->prepare("SELECT id FROM users WHERE email = ?");
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $stmt->store_result();

    if ($stmt->num_rows === 0) {
        echo json_encode(["error" => "Email not found."]);
        $stmt->close();
        $conn->close();
        exit;
    }
    $stmt->close();

    // Hash and update password
    $hashed = password_hash($newPassword, PASSWORD_BCRYPT);

    $stmt = $conn->prepare("UPDATE users SET password_hash = ? WHERE email = ?");
    $stmt->bind_param("ss", $hashed, $email);

    if ($stmt->execute()) {
        echo json_encode(["success" => true]);
    } else {
        echo json_encode(["error" => "Failed to reset password."]);
    }

    $stmt->close();
} else {
    echo json_encode(["error" => "Invalid request method."]);
}

$conn->close();
