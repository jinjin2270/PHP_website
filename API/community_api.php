<?php
session_start();
header('Content-Type: application/json');

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "foodfusion";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die(json_encode(['error' => 'Database connection failed']));
}


$action = $_GET['action'] ?? '';

switch ($action) {
    case 'get_posts':
        handleGetPosts($conn);
        break;
    case 'create_post':
        handleCreatePost($conn);
        break;
    case 'like_post':
        handleLikePost($conn);
        break;
    case 'unlike_post':          
        handleUnlikePost($conn);  
        break;
    case 'add_comment':
        handleAddComment($conn);
    break;

    default:
        echo json_encode(['error' => 'Invalid action']);
}

function handleGetPosts($conn) {
    $response = ['isLoggedIn' => isset($_SESSION['user_id']), 'posts' => []];
    
    // Get posts
    $posts_sql = "SELECT p.*, u.email as username, 
                 (SELECT COUNT(*) FROM likes WHERE post_id = p.id) as like_count,
                 (SELECT COUNT(*) FROM comments WHERE post_id = p.id) as comment_count
                 FROM posts p JOIN users u ON p.user_id = u.id
                 ORDER BY p.created_at DESC";
    $posts_result = $conn->query($posts_sql);
    
    while ($post = $posts_result->fetch_assoc()) {
        // Check if current user liked this post
        $post['isLiked'] = false;
        if (isset($_SESSION['user_id'])) {
            $like_check = $conn->query("SELECT 1 FROM likes WHERE post_id = {$post['id']} AND user_id = {$_SESSION['user_id']}");
            $post['isLiked'] = $like_check->num_rows > 0;
        }
        
        // Get comments
        $post['comments'] = [];
        $comments_sql = "SELECT c.*, u.email as username 
                        FROM comments c JOIN users u ON c.user_id = u.id
                        WHERE c.post_id = {$post['id']}
                        ORDER BY c.created_at DESC LIMIT 2";
        $comments_result = $conn->query($comments_sql);
        while ($comment = $comments_result->fetch_assoc()) {
            $post['comments'][] = $comment;
        }
        
        $response['posts'][] = $post;
    }
    
    echo json_encode($response);
}

function handleCreatePost($conn) {
    if (!isset($_SESSION['user_id'])) {
        echo json_encode(['error' => 'Not authenticated']);
        return;
    }
    
    $user_id = $_SESSION['user_id'];
    $caption = $conn->real_escape_string($_POST['caption']);
    
    // Handle file upload
    $image_path = '';
    if (isset($_FILES['image'])) {
        $target_dir = __DIR__ . '/../uploads/';
        if (!file_exists($target_dir)) {
            mkdir($target_dir, 0777, true);
        }
        
        $file_ext = pathinfo($_FILES['image']['name'], PATHINFO_EXTENSION);
        $filename = uniqid() . '.' . $file_ext;
        $target_file = $target_dir . $filename;
        
        if (move_uploaded_file($_FILES['image']['tmp_name'], $target_file)) {
            // Store the web-accessible path, not server path
            $image_path = 'uploads/' . $filename; 
        }
    }
    
    $sql = "INSERT INTO posts (user_id, caption, image_path, created_at) 
            VALUES ('$user_id', '$caption', '$image_path', NOW())";
    
    if ($conn->query($sql)) {
        echo json_encode(['success' => true, 'imagePath' => $image_path]); // Return the path for debugging
    } else {
        echo json_encode(['error' => 'Failed to create post']);
    }
}

function handleLikePost($conn) {
    if (!isset($_SESSION['user_id'])) {
        echo json_encode(['error' => 'Not authenticated']);
        return;
    }
    
    $user_id = $_SESSION['user_id'];
    $post_id = intval($_GET['post_id']);
    
    // Check if already liked
    $check_sql = "SELECT 1 FROM likes WHERE user_id = $user_id AND post_id = $post_id";
    if ($conn->query($check_sql)->num_rows > 0) {
        echo json_encode(['error' => 'Already liked']);
        return;
    }
    
    // Add like
    $like_sql = "INSERT INTO likes (user_id, post_id) VALUES ($user_id, $post_id)";
    if ($conn->query($like_sql)) {
        echo json_encode(['success' => true]);
    } else {
        echo json_encode(['error' => 'Failed to like post']);
    }
}

function handleUnlikePost($conn) {
    if (!isset($_SESSION['user_id'])) {
        echo json_encode(['error' => 'Not authenticated']);
        return;
    }

    $user_id = $_SESSION['user_id'];
    $post_id = intval($_GET['post_id']);

    // Delete the like record if it exists
    $sql = "DELETE FROM likes WHERE user_id = $user_id AND post_id = $post_id";
    if ($conn->query($sql)) {
        echo json_encode(['success' => true]);
    } else {
        echo json_encode(['error' => 'Failed to unlike post']);
    }
}

function handleAddComment($conn) {
    if (!isset($_SESSION['user_id'])) {
        echo json_encode(['error' => 'Not authenticated']);
        return;
    }

    $user_id = $_SESSION['user_id'];
    $post_id = intval($_GET['post_id']);
    $comment_text = $conn->real_escape_string($_POST['comment']);

    if (empty($comment_text)) {
        echo json_encode(['error' => 'Comment cannot be empty']);
        return;
    }

    $sql = "INSERT INTO comments (user_id, post_id, text, created_at) 
            VALUES ('$user_id', '$post_id', '$comment_text', NOW())";

    if ($conn->query($sql)) {
        echo json_encode(['success' => true]);
    } else {
        echo json_encode(['error' => 'Failed to add comment']);
    }
}


$conn->close();
?>