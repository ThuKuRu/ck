<?php
// Include database, session, general info
require_once 'init/init.php';
// Xoá session
$session->destroy();
// Trở về trang chủ
header('Location: index.php');

?>