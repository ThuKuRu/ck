<?php 
    require_once "Object/db.php";
    require_once "Object/session.php";
    
    $db = new DB();
    $db -> connect();
    $session = new Session();
    $session ->start();
    $user = $session->get();

    date_default_timezone_set('Asia/Ho_Chi_Minh');
    $date_current = '';
    $date_current = date("Y-m-d H:i:sa");   
    if($user["username"] != ''){
        $get_data_user = "SELECT * FROM ".$user["type_account"]." WHERE username = '".$user["username"]."'";
    }
?>
