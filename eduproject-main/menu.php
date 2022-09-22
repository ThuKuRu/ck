<head>
    <link rel="stylesheet" href="style/menu.css">
</head>
<?php if($user["type_account"] == 'hocsinh'){ ?>
<div class="menu">
        <ul>
            <li><a id ="hocsinhinfo" >Info</a></li>
            <li><a id = "tkb">Thời Khóa Biểu</a></li>
            <li><a id = "bangdiem">Bảng Điểm Cá Nhân</a></li>
            <li><a id = "dangky">Đăng Ký Lớp Học</a></li>
            <li><a href="logout.php" >Log out</a></li>
        </ul>
</div>
<div class="iframe">
<?php if($user["username"] != ''){
        if($get_data_user = $db->getdata("SELECT * FROM ".$user["type_account"]." WHERE username = '".$user["username"]."'")){
?>
        <div class="infobox">
    <ul>
        <li>MSSV: <?php echo $get_data_user["mssv"] ?></li>
        <li>Name: <?php echo $get_data_user["name"] ?></li>
        <li>Date of Birth: <?php echo $get_data_user["dob"] ?></li>
        <li>Gender: <?php if($get_data_user["sex"])echo "Female"; else echo "Male" ?></li>
        <li>Address:  <?php echo $get_data_user["address"] ?></li>
        <li>Quê Quán: <?php echo $get_data_user["quequan"] ?></li>
        <li>NumberPhone: <?php echo $get_data_user["phone"] ?></li>
        <li>Email: <?php echo $get_data_user["email"] ?></li>
    </ul>
</div>
<?php
        }
    }
?>
</div>
<div class="clear"></div>




<?php } else if($user["type_account"] == "giaovien")  { ?>
<div class="menu">
        <ul>
            <li><a id ="gvif">Info</a></li>
            <li><a id ="giaovientkb">Thời Khóa Biểu</a></li>
            <li><a id ="quanly">Quản Lý Lớp Học</a></li>
            <li><a id="taolophoc">Tạo Lớp Học</a></li>
            <li><a href="logout.php">Log out</a></li> 
           
        </ul>
</div>
<div class="iframe">
<?php if($user["username"] != ''){
        if($get_data_user = $db->getdata("SELECT * FROM ".$user["type_account"]." WHERE username = '".$user["username"]."'")){
?>
        <div class="infobox">
    <ul>
        <li>MSGV: <?php echo $get_data_user["msgv"] ?></li>
        <li>Name: <?php echo $get_data_user["name"] ?></li>
        <li>Date of Birth: <?php echo $get_data_user["dob"] ?></li>
        <li>Gender: <?php if($get_data_user["sex"])echo "Female"; else echo "Male" ?></li>
        <li>Address:  <?php echo $get_data_user["address"] ?></li>
        <li>Quê Quán: <?php echo $get_data_user["quequan"] ?></li>
        <li>NumberPhone: <?php echo $get_data_user["phone"] ?></li>
        <li>Email: <?php echo $get_data_user["email"] ?></li>
    </ul>
</div>
<?php
        }
    }
?>
</div>
<div class="clear"></div>
<?php } ?>