<div class="tableofbook" style="overflow-x: auto;">
		
		<table>
			  <tr>
				<th>Kỳ</th>
				<th>Mã Môn</th>
				<th>Tên Môn Học</th>
                <th>Điểm Giữa Kỳ</th>
                <th>Điểm Cuối Kỳ</th>
			  </tr>
<?php 

// Perform query
    require_once "../Object/db.php";
    $conn = new DB();
    $conn -> connect();
    $username = $_POST['username'];
    $row = $conn->getdata("SELECT mssv FROM hocsinh WHERE username = '$username'");
	$query = "SELECT * FROM ((dangky inner join lop on lop.class_id = dangky.class_id) inner join baikiemtra on lop.class_id = baikiemtra.class_id)inner join monhoc on monhoc.mamonhoc = lop.mamonhoc  WHERE baikiemtra.mssv = ".$row["mssv"]. " ORDER BY namhoc ASC, kyhoc ASC" ;
if ($result = $conn -> getdata($query)) {
    if($conn -> num_rows($query) == 1){ $results =array($result) ;}
    else if($conn -> num_rows($query) > 1) {$results = $result;}
    foreach($results as $rows){
?>
 	<tr>

 		<td><?php  echo $rows["namhoc"].$rows["kyhoc"]; ?></td>
 		<td><?php  echo $rows["mamonhoc"]; ?></td>
 		<td><?php  echo $rows["tenmonhoc"]; ?></td>
        <td><?php  if($rows['diemgiuaky'] != '') echo $rows['diemgiuaky']; ?></td>
		<td><?php if( $rows['diemcuoiky'] != '') echo $rows['diemcuoiky']; ?></td>
<?php
}?>
 	</tr>
<?php
}
?>
</table>