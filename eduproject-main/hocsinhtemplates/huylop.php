<?php
require_once "../Object/db.php";
    $conn = new DB();
    $conn -> connect();
    $username = $_POST['username'];
    $class_id = $_POST['class_id'];
    $user = $conn-> getdata("SELECT mssv FROM hocsinh WHERE username = '$username'");
    $query = "DELETE FROM dangky WHERE mssv = ".$user['mssv']." AND class_id = $class_id";
    $conn -> query($query);
    echo "Xoá Lớp Thành Công";
?>