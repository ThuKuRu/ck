
<?php 
    require_once "../Object/db.php";
    $conn = new DB();
    $conn -> connect();
    $searchbookErr = $searchbook = "";
	if(empty($_GET["search"])){
		$searchbookErr = "search is required";
	}
    else $searchbook = $_GET["search"];
?>
<div class = "searchbar">
		<form onsubmit="return false;" >
			<input type = "search" placeholder ="Tìm Theo Mã Môn Học" autocomplete="on" name="searchbook"> 
			<button id ="searchid" type="submit" onclick = "searchdangky()"><i class="fa fa-search"></i></button>
		</form>
</div>


<div class="tableofbook" style="overflow-x: auto;">
		
		<table>
			  <tr>
				<th>class_id</th>
				<th>Mã Môn Học</th>
				<th>Tên Môn Học</th>
                <th>Thứ</th>
                <th>Giờ</th>
                <th>Kỳ Học</th>
                <th>Đã Đăng Ký</th>
			  </tr>
<?php 

// Perform query

if ($searchbook == ""){
	$query = 'SELECT * FROM lop inner join monhoc on lop.mamonhoc = monhoc.mamonhoc WHERE status = true';
	
}
else{
	$query = "SELECT * FROM lop inner join monhoc on lop.mamonhoc = monhoc.mamonhoc WHERE (status = true AND (lop.mamonhoc = '$searchbook' )) ";
    
}
if ($result = $conn -> getdata($query)) {
    if($conn -> num_rows($query) == 1){$results[] = $result;}
    else if($conn -> num_rows($query) > 1) {$results = $result;}
    foreach($results as $row){
?>
 	<tr>

 		<td><?php  echo $row["class_id"]; ?></td>
 		<td><?php  echo $row["mamonhoc"]; ?></td>
 		<td><?php  echo $row["tenmonhoc"]; ?></td>
 		<td><?php  echo $row["ngaytrongtuan"]; ?></td>
        <td><?php  echo $row["giohoc"]; ?></td>
        <td><?php  echo $row["namhoc"].$row["kyhoc"]; ?></td>
        <td><?php $num =  $conn -> getdata("select count(mssv) from lop left join dangky on lop.class_id = dangky.class_id WHERE lop.class_id = ".$row['class_id']." group by lop.class_id"); if($num['count'] == '')echo('0'); else echo $num['count']; ?></td>
		<td><form onsubmit="return false;">
				<input type="hidden" name = "class_id" value = "<?php echo $row["class_id"]; ?>"> 
		 		<button type = "submit" onclick = "dangkylop(<?php echo $row['class_id']; ?>)">Đăng Ký</button>
		</form></td>
<?php
}?>
 	</tr>
<?php
}
?>
</table>