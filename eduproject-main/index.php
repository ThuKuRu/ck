<?php 
    require_once 'init/init.php';
    require_once 'includes/header.php';
    if($user["username"] == ''){
        require_once "templates/signin_form.php";
    }
    else{
        require_once "menu.php";
    }
    
    require_once 'includes/footer.php';
?>
