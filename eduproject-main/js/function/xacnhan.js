function xacnhan(class_id){
    $username = $('input[name = "usernamecurrent"]').val();
    $user_type = $('input[name ="typecurrent"]').val();
    $.ajax({
        url: "giaovientemplates/giaovientkb.php",
        type: "POST",
        data:{
            username: $username,
            user_type: $user_type,
            class_id :class_id,
            ac:"xacnhan"
        }
    }).done(function(data){
        alert('Xác Nhận Thành Công');
        $('.iframe').html(data);
    });
}