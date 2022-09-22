function huy(class_id){
    $username = $('input[name = "usernamecurrent"]').val();
    $user_type = $('input[name ="typecurrent"]').val();
    $.ajax({
        url: "giaovientemplates/giaovientkb.php",
        type: "POST",
        data:{
            class_id :class_id,
            ac:"huy",
            username: $username,
            user_type: $user_type
        }
    }).done(function(data){
        alert('Huỷ Lớp Thành Công');
        $('.iframe').html(data);
    });
}