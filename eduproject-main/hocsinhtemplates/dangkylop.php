<?php
        require_once "../Object/db.php";
        $conn = new DB();
        $conn -> connect();
        $username = $_POST['username'];
        $class_id = $_POST['class_id'];
        $err = "";
        $query1 = "SELECT * FROM lop WHERE class_id = ".$class_id;
        if($conn -> num_rows($query1) == 1){
            $result1 = $conn -> getdata($query1);
            $user = $conn -> getdata("SELECT * FROM hocsinh WHERE username = '$username'");
            $query2 = "SELECT * FROM lop INNER JOIN dangky ON dangky.class_id = lop.class_id WHERE mssv = ".$user['mssv'];
            if($conn -> num_rows($query2)>=1){
                $result2 = $conn -> getdata($query2);
                
                if($conn -> num_rows($query2) == 1){
                    $result[] = $result2;
                }
                else if ($conn -> num_rows($query2) > 1){
                    $result = $result2;
                }
                
                foreach($result as $row){
                if(abs(strtotime($result1['giohoc']) - strtotime($row['giohoc'])) <= 3600 && $row['ngaytrongtuan'] == $result1['ngaytrongtuan']){
                    $err = 'Trùng Lịch';
                }
                }
                foreach($result as $row){
                    if( $row['mamonhoc'] == $result1['mamonhoc']){
                        $err = 'Đã Đăng Ký Môn Này!';
                    }
                    }
            }
            if($err != ''){
                echo $err;
            }
            else{
                $query = 'INSERT INTO dangky VALUES('.$user["mssv"].','.$class_id.')';
                $conn -> query($query);
                echo "ĐĂNG KÝ LỚP THÀNH CÔNG";
            }
        }
        
?>