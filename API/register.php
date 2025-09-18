<?php
header("Content-Type: application/json");

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "foodfusion";


$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    echo json_encode(["error" => "Database connection failed."]);
    exit();
}

$first = $_POST['firstName'] ?? '';
$last = $_POST['lastName'] ?? '';
$email = $_POST['email'] ?? '';
$password = $_POST['password'] ?? '';
$confirm = $_POST['confirmPassword'] ?? '';

if (!$first || !$last || !$email || !$password || !$confirm) {
    echo json_encode(["error" => "All fields are required."]);
    exit();
}

if ($password !== $confirm) {
    echo json_encode(["error" => "Passwords do not match."]);
    exit();
}

if (strlen($password) < 8) {
    echo json_encode(["error" => "Password must be at least 8 characters."]);
    exit();
}

$hash = password_hash($password, PASSWORD_DEFAULT);
$stmt = $conn->prepare("INSERT INTO users (first_name, last_name, email, password_hash) VALUES (?, ?, ?, ?)");
$stmt->bind_param("ssss", $first, $last, $email, $hash);

if ($stmt->execute()) {
    echo json_encode(["message" => "Registration successful."]);
} else {
    echo json_encode(["error" => "Email already exists or failed."]);
}

$conn->close();
?>
