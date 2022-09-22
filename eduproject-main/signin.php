<?php
    require_once "init/init.php";
    if ($user["username"] != ''){
	    header('Location: index.php'); // Di chuyển đến trang chủ
    }
    $user_signin = $db->real_escape_string(@$_POST['user_signin']);
    $pass_signin = ($_POST['pass_signin']);
    $type = $_POST['typesignin'];
    // Lệnh SQL kiểm tra sự tồn tại của username
    $show_alert = "<script>$('#formSignin .alert').removeClass('hidden');</script>";
    $hide_alert = "<script>$('#formSignin .alert').addClass('hidden');</script>";
    $success_alert = "<script>$('#formSignin .alert').html('Đăng nhập thành công.'); location.reload();</script>";
    $show  = " <script>$('#formSignin .alert') ";

    $sql_check_user_exist = "SELECT username FROM ".$type." WHERE username = '$user_signin' AND password = '$pass_signin'";
    if($db->num_rows($sql_check_user_exist) != 0){
        $session->send($user_signin,$type);
        echo $success_alert;
    }
    else
    {
	    echo $show.".html('Tên đăng nhập hoặc mật khẩu sai!')</script>";
    }
?>