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

$search = isset($_GET['search']) ? $conn->real_escape_string($_GET['search']) : '';
$cuisine = isset($_GET['cuisine']) ? $conn->real_escape_string($_GET['cuisine']) : '';
$diet = isset($_GET['diet']) ? $conn->real_escape_string($_GET['diet']) : '';
$difficulty = isset($_GET['difficulty']) ? $conn->real_escape_string($_GET['difficulty']) : '';

$sql = "SELECT r.title, r.image_url, r.description,
               c.name AS cuisine, d.name AS diet, dl.level AS difficulty
        FROM recipes r
        LEFT JOIN cuisine_types c ON r.cuisine_id = c.id
        LEFT JOIN dietary_preferences d ON r.diet_id = d.id
        LEFT JOIN difficulty_levels dl ON r.difficulty_id = dl.id
        WHERE 1=1";

if ($search !== '') {
    $sql .= " AND r.title LIKE '%$search%'";
}
if ($cuisine !== '') {
    $sql .= " AND c.name = '$cuisine'";
}
if ($diet !== '') {
    $sql .= " AND d.name = '$diet'";
}
if ($difficulty !== '') {
    $sql .= " AND dl.level = '$difficulty'";
}

$result = $conn->query($sql);

$recipes = [];

if ($result && $result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $recipes[] = $row;
    }
}

echo json_encode($recipes);
$conn->close();
?>
