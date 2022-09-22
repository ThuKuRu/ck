<?php 
    require_once "../Object/db.php";
    $conn = new DB();
    $conn -> connect();
    $username = $_POST['username'];
    $type = $_POST['user_type'];
    $get_info = "SELECT * FROM $type WHERE username = '$username'";
    if($conn->cn){
        if($user_info = $conn->getdata($get_info)){
?>
<div class="infobox">
    <ul>
        <li>MSGV: <?php echo $user_info["msgv"] ?></li>
        <li>Name: <?php echo $user_info["name"] ?></li>
        <li>Date of Birth: <?php echo $user_info["dob"] ?></li>
        <li>Gender: <?php if($user_info["sex"])echo "Female"; else echo "Male" ?></li>
        <li>Address:  <?php echo $user_info["address"] ?></li>
        <li>Quê Quán: <?php echo $user_info["quequan"] ?></li>
        <li>NumberPhone: <?php echo $user_info["phone"] ?></li>
        <li>Email: <?php echo $user_info["email"] ?></li>
    </ul>
</div>
<?php }}?>