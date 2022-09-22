<?php
    require_once "../Object/db.php";
    $conn = new DB();
    $conn -> connect();
    if(isset($_POST['ac'])){
        if($_POST['ac'] == 'xacnhan'){
            $query = "UPDATE lop SET status = 'f' WHERE class_id = ".$_POST['class_id'];
            $conn -> query($query);
        }
        else if($_POST['ac'] == 'huy'){
            $query = "DELETE FROM dangky WHERE class_id = ".$_POST['class_id'];
            $conn -> query($query);
            $query = "DELETE FROM lop WHERE class_id = ".$_POST['class_id'];
            $conn -> query($query);
        }
    }
?>
<div class="tableofbook" style="overflow-x: auto;">
		<h1 style = "text-align:center;">THỜI KHÓA BIỂU</h1>
		<table>
			  <tr>
				<th>Thứ</th>
				<th>Giờ</th>
				<th>Tên Môn Học</th>
                <th>Mã Lớp Học</th>
                <th>Phòng Học</th>
                <th></th>
                <th></th>
			  </tr>
<?php 

// Perform query
    
    $username = $_POST['username'];
    $row = $conn->getdata("SELECT msgv FROM giaovien WHERE username = '$username'");
	$query = "SELECT * FROM lop inner join monhoc on lop.mamonhoc = monhoc.mamonhoc WHERE namhoc = date_part('year',CURRENT_DATE) AND kyhoc = (select (date_part('month',CURRENT_DATE)/4)::numeric::integer) AND msgv = '".$row["msgv"] ."' ORDER BY ngaytrongtuan ASC, giohoc ASC ";
if ($result = $conn -> getdata($query)) {
    if($conn -> num_rows($query) == 1){$results[] = $result;}
    else if($conn -> num_rows($query) > 1) $results = $result;
    foreach($results as $row){
?>
 	<tr>

 		<td><?php  echo $row["ngaytrongtuan"]; ?></td>
 		<td><?php  echo $row["giohoc"]; ?></td>
 		<td><?php  echo $row["tenmonhoc"]; ?></td>
        <td><?php  echo $row["class_id"]; ?></td>
        <td><?php  echo $row["phonghoc"]; ?></td>
        <?php if($row['status'] == 't') {  ?>  <td><button onclick = "xacnhan(<?php echo $row['class_id']; ?>)">Xác Nhận</button></td> <?php }?>
        <?php if($row['status'] == 't') {  ?>  <td><button onclick = "huy(<?php echo $row['class_id']; ?>)">Hủy Lớp</button></td> <?php }?>
<?php
}?>
 	</tr>
<?php
}
?>
</table>