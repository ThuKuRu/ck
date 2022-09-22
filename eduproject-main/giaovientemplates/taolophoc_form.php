<?php 
    require_once "../Object/db.php";
    $conn = new DB();
    $conn -> connect();
    $username = $_POST['username'];
    $type = $_POST['user_type'];
    $get_info = "SELECT msgv FROM $type WHERE username = '$username'";
    if($conn->cn){
        if($user_info = $conn->getdata($get_info)){
?>
<div class="infobox">
    <h1>Tạo Lớp Học</h1>
    <h2>Kỳ Học <?php echo date('Y');echo round(date('m')/4) ?></h2>
    <form method="POST" onsubmit="return false;" id="createclassform">
        <select id="mon">
            <?php $getmonday = "SELECT mamonhoc FROM monday WHERE msgv = ".$user_info["msgv"];
            $monhoc = $conn->getdata($getmonday);
            if($conn->num_rows($getmonday) == 1){
            foreach($monhoc as $mon){ ?>
            <option value="<?php echo $mon ?> " id="<?php echo $mon ?> "><?php echo $mon ?> </option>
            <?php }}else if($conn->num_rows($getmonday) > 1){
            foreach($monhoc as $mon){     ?>
            <option value="<?php echo $mon['mamonhoc'] ?> " id="<?php echo $mon['mamonhoc'] ?> "><?php echo $mon['mamonhoc'] ?> </option>
            <?php }}?>
        </select>
        <label for = "thu">Thứ</label>
        <input type="number" id = "thu" name="Thu" min ="2" max = "7">
        <label for="usr_time">Giờ Học</label>
        <input type="time" id = "usr_time" name="usr_time">
        <label for="lophoc">Phòng Học</label>
        <select id="lophoc">
            <?php $getlop = "SELECT phonghoc FROM lophoc";
            $lp = $conn->getdata($getlop);
            foreach($lp as $l){ ?>
            <option value="<?php echo $l["phonghoc"] ?> " id="<?php echo $l["phonghoc"] ?> "><?php echo $l["phonghoc"] ?> </option>
            <?php } ?>
        </select>
        <button id ="submitcreate" onclick = "createlop()" >Create</button>
    </form>
</div>
<?php }}?>