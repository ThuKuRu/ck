<?php
 require_once "../Object/db.php";
 $conn = new DB();
 $conn -> connect();
    if(isset($_POST['giuaky']) && $_POST['giuaky'] != ''){
        if($_POST['giuaky'] < 0 || $_POST['giuaky'] > 10){
            echo "<script> alert('Điểm Giữa Kỳ Phải Nằm Trong 1-10') </script>";
        }
        else{
            $query = "UPDATE baikiemtra SET diemgiuaky = ".$_POST['giuaky']." WHERE mssv = ".$_POST['mssv']." AND class_id = ".$_POST['class_id'];
            $conn -> query($query);
            echo "<script> alert('cập nhật điểm giữa kỳ cho sinh viên có mssv: ".$_POST['mssv']." Thành Công') </script>";
        }
    }
    if(isset($_POST['cuoiky']) && $_POST['cuoiky'] != ''){
        if($_POST['cuoiky'] < 0 || $_POST['cuoiky'] > 10 ){
            echo "<script> alert('Điểm Cuối Kỳ Phải Nằm Trong 1-10') </script>";
        }
        else{
        $query = "UPDATE baikiemtra SET diemcuoiky = ".$_POST['cuoiky']." WHERE mssv = ".$_POST['mssv']." AND class_id = ".$_POST['class_id'];
        $conn -> query($query);
        echo "<script> alert('cập nhật điểm cuối kỳ cho sinh viên có mssv: ".$_POST['mssv']." Thành Công') </script>";
        }
    }
?>
<div class="tableofbook" style="overflow-x: auto;">
		
		<table>
			  <tr>
				<th>Học Sinh</th>
				<th>Tên Môn Học</th>
                <th>Điểm Giữa Kỳ</th>
                <th>Điểm Cuối Kỳ</th>
                <th>Cập Nhật</th>
			  </tr>
<?php 

// Perform query
    $class_id = $_POST['class_id'];
	$query = "SELECT * FROM (((dangky inner join lop on lop.class_id = dangky.class_id) inner join baikiemtra on dangky.mssv = baikiemtra.mssv)inner join monhoc on monhoc.mamonhoc = lop.mamonhoc)inner join hocsinh on dangky.mssv = hocsinh.mssv WHERE lop.class_id = $class_id ORDER BY namhoc ASC, kyhoc ASC" ;
if ($result = $conn -> getdata($query)) {
    if($conn -> num_rows($query) == 1){ $results =array($result) ;}
    else if($conn -> num_rows($query) > 1) {$results = $result;}
    foreach($results as $rows){
?>
 	<tr>
 		<td><?php  echo $rows["name"]; ?></td>
 		<td><?php  echo $rows["tenmonhoc"]; ?></td>
        <form onsubmit = "return false">
        <td><input  type = "text"  step = "0.5" min ="0" placeholder = "<?php  if($rows['diemgiuaky'] != '') echo $rows['diemgiuaky']; ?>" name ='<?php echo $rows['mssv']."g";?>' ></td>
		<td><input  type = "text" step = "0.5"  min = "0" placeholder = "<?php  if($rows['diemgiuaky'] != '') echo $rows['diemcuoiky']; ?>" name = '<?php echo $rows['mssv']."c"; ?>' ></td>
        <td><button onclick = "capnhat(<?php echo $rows['mssv'].','.$class_id; ?>)">Cập Nhật</button></td>
        </form>
<?php
}?>
 	</tr>
<?php
}
?>
</table>