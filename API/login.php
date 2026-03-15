<?php
session_start();
header("Content-Type: application/json");

// Database configuration
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "foodfusion";

try {
    $conn = new mysqli($servername, $username, $password, $dbname);
    
    if ($conn->connect_error) {
        throw new Exception("Database connection failed: " . $conn->connect_error);
    }

    $email = $_POST['email'] ?? '';
    $password = $_POST['password'] ?? '';

    if (!$email || !$password) {
        throw new Exception("Email and password are required.");
    }

    $stmt = $conn->prepare("SELECT id, email, password_hash, is_locked, last_failed_login, failed_attempts FROM users WHERE email = ?");
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows === 0) {
        throw new Exception("Invalid credentials.");
    }

    $user = $result->fetch_assoc();

    // Check if account is locked
    if ($user['is_locked']) {
        $last = strtotime($user['last_failed_login']);
        if (time() - $last < 180) {
            throw new Exception("Account locked. Try again in 3 minutes.");
        } else {
            $conn->query("UPDATE users SET is_locked = 0, failed_attempts = 0 WHERE id = {$user['id']}");
        }
    }

    if (password_verify($password, $user['password_hash'])) {
        $_SESSION['user_id'] = $user['id'];
        $_SESSION['email'] = $user['email'];
        $conn->query("UPDATE users SET failed_attempts = 0 WHERE id = {$user['id']}");
        
        echo json_encode([
            "success" => true,
            "message" => "Login successful.",
            "email" => $user['email']
        ]);
    } else {
        $attempts = $user['failed_attempts'] + 1;
        $locked = $attempts >= 3 ? 1 : 0;

        $stmt = $conn->prepare("UPDATE users SET failed_attempts = ?, last_failed_login = NOW(), is_locked = ? WHERE id = ?");
        $stmt->bind_param("iii", $attempts, $locked, $user['id']);
        $stmt->execute();

        throw new Exception($locked 
            ? "Too many attempts. Locked for 3 minutes."
            : "Incorrect password."
        );
    }
} catch (Exception $e) {
    echo json_encode([
        "success" => false,
        "error" => $e->getMessage()
    ]);
} finally {
    if (isset($conn)) {
        $conn->close();
    }
}
?>