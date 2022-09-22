<div class="tableofbook" style="overflow-x: auto;">
		<h1 style = "text-align: center;"> THỜI KHÓA BIỂU </h1>
		<table>
			  <tr>
				<th>Thứ</th>
				<th>Giờ</th>
				<th>Tên Môn Học</th>
                <th>Mã Lớp Học</th>
                <th>Phòng Học</th>
                <th></th>
			  </tr>
<?php 

// Perform query
    require_once "../Object/db.php";
    $conn = new DB();
    $conn -> connect();
    $username = $_POST['username'];
    $row = $conn->getdata("SELECT mssv FROM hocsinh WHERE username = '$username'");
	$query = "SELECT * FROM (lop inner join dangky on lop.class_id = dangky.class_id) inner join monhoc on monhoc.mamonhoc = lop.mamonhoc WHERE namhoc = date_part('year',CURRENT_DATE) AND kyhoc = (select (date_part('month',CURRENT_DATE)/4)::numeric::integer) AND mssv = ".$row["mssv"]." ORDER BY ngaytrongtuan ASC, giohoc ASC ";
if ($result = $conn -> getdata($query)) {
    if($conn -> num_rows($query) == 1){ $results =array($result) ;}
    else if($conn -> num_rows($query) > 1) {$results = $result;}
    foreach($results as $rows){
?>
 	<tr>

 		<td><?php  echo $rows["ngaytrongtuan"]; ?></td>
 		<td><?php  echo $rows["giohoc"]; ?></td>
 		<td><?php  echo $rows["tenmonhoc"]; ?></td>
        <td><?php  echo $rows["class_id"]; ?></td>
        <td><?php  echo $rows["phonghoc"]; ?></td>
        <?php if($rows["status"] == 't'){ ?>
        <td><button onclick= "huylop(<?php echo $rows['class_id'];?>)">Hủy Lớp</button></td>
        <?php } ?>
<?php
}?>
 	</tr>
<?php
}
?>
</table>