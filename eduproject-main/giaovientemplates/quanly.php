<?php 
    require_once "../Object/db.php";
    $conn = new DB();
    $conn -> connect();
?>
<div class="tableofbook" style="overflow-x: auto;">
		<h1 style = "text-align:center;">Quản Lý Lớp Học</h1>
		<table>
			  <tr>
                <th>Kỳ Học</th>
				<th>Class ID</th>
				<th>Tên Môn Học</th>
                <th>Số Lượng</th>
                <th></th>
			  </tr>
<?php 

// Perform query
    require_once "../Object/db.php";
    $conn = new DB();
    $conn -> connect();
    $username = $_POST['username'];
    $row = $conn->getdata("SELECT msgv FROM giaovien WHERE username = '$username'");
	$query = "SELECT * FROM lop inner join monhoc on lop.mamonhoc = monhoc.mamonhoc WHERE status = 'f' AND msgv = ".$row["msgv"] ." ORDER BY namhoc ASC,kyhoc  ASC ";
if ($result = $conn -> getdata($query)) {
    if($conn -> num_rows($query) == 1){$results[] = $result;}
    else if($conn -> num_rows($query) > 1) $results = $result;
    foreach($results as $row){
?>
 	<tr>
        <td><?php  echo $row["namhoc"].$row["kyhoc"]; ?></td>
        <td><?php  echo $row["class_id"]; ?></td>
        <td><?php  echo $row["tenmonhoc"]; ?></td>
        <td><?php $num =  $conn -> getdata("select count(mssv) from lop left join dangky on lop.class_id = dangky.class_id WHERE lop.class_id = ".$row['class_id']." group by lop.class_id"); if($num['count'] == '')echo('0'); else echo $num['count']; ?></td>
        <td><button onclick = "quanlylop(<?php echo $row['class_id'] ?>)">Check</button></td>
<?php
}?>
 	</tr>
<?php
}
?>
</table>