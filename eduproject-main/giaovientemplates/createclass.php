<?php 
    require_once "../Object/db.php";
    $conn = new DB();
    $conn -> connect();
    $username = trim($_POST['username']);
    $type = $_POST['type'];
    $thu = $_POST['thu'];
    $time = $_POST['time'];
    $lop = trim($_POST['lop']);
    $mon = trim($_POST['mon']);
    $usergv = $conn->getdata("SELECT msgv FROM giaovien WHERE username = '$username'");
    $error = "";
    if($thu == ''||$time == ''||$lop ==''){
        $error = "Vui Lòng Nhập Đủ Thông Tin";
    }
    else if(strtotime($time) -strtotime("06:00:00") < 0 || strtotime($time) -strtotime("17:30:00") > 0){
        $error = "Ngoài Giờ Hành Chính";
    }
    else{
    $get = "SELECT * FROM lop WHERE namhoc = date_part('year',CURRENT_DATE) AND kyhoc = (select (date_part('month',CURRENT_DATE)/4)::numeric::integer)";
    if($conn->num_rows($get) == 1){
        $data = $conn->getdata($get);
        if($thu == $data['ngaytrongtuan'] && (abs(strtotime($time)-strtotime($data['giohoc']))) <= 3600 && $lop == trim($data['phonghoc'])){
            $error = "Trùng Lịch";
        }
    }
    else if($conn->num_rows($get) >1){
        $getdata = $conn->getdata($get);
        foreach($getdata as $data){
        if($thu == $data['ngaytrongtuan'] && (abs(strtotime($time)-strtotime($data['giohoc']))) <= 3600 && $lop == trim($data['phonghoc'])){
            $error = "Trùng Lịch";
        }
    }
    }
    $get = "SELECT * FROM lop WHERE namhoc = date_part('year',CURRENT_DATE) AND kyhoc = (select (date_part('month',CURRENT_DATE)/4)::numeric::integer) AND msgv = ".$usergv['msgv'];
    if($conn->num_rows($get) == 1){
        $data = $conn->getdata($get);
        if($thu == $data['ngaytrongtuan'] && (abs(strtotime($time)-strtotime($data['giohoc']))) <= 3600 ){
            $error = "Trùng Lịch";
        }
    }
    else if($conn->num_rows($get) >1){
        $getdata = $conn->getdata($get);
        foreach($getdata as $data){
        if($thu == $data['ngaytrongtuan'] && (abs(strtotime($time)-strtotime($data['giohoc']))) <= 3600 ){
            $error = "Trùng Lịch";
        }
    }
    }
    }
    if($error != ''){
        echo $error;
    }
    else{
        $create = "INSERT INTO lop(mamonhoc,msgv,giohoc,ngaytrongtuan,phonghoc) VALUES('$mon',".$usergv['msgv'].",'$time',$thu,'$lop') ";
        $conn -> query($create);
        echo "Thêm Lớp Thành Công";
    }
?>