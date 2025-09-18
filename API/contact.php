<?php
header('Content-Type: application/json');
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "foodfusion";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    echo json_encode(['error' => 'Database connection failed']);
    exit;
}

$name = $conn->real_escape_string($_POST['name'] ?? '');
$email = $conn->real_escape_string($_POST['email'] ?? '');
$topic = $conn->real_escape_string($_POST['topic'] ?? '');
$message = $conn->real_escape_string($_POST['message'] ?? '');

if (!$name || !$email || !$topic || !$message) {
    echo json_encode(['error' => 'All fields are required']);
    exit;
}

$sql = "INSERT INTO contacts (name, email, topic, message, submitted_at)
        VALUES ('$name', '$email', '$topic', '$message', NOW())";

if ($conn->query($sql)) {
    echo json_encode(['success' => true]);
} else {
    echo json_encode(['error' => 'Database error']);
}

$conn->close();
?>
