function dangkylop($class_id){
    $username = $('input[name = "usernamecurrent"]').val();
    $user_type = $('input[name ="typecurrent"]').val();
    $.ajax({
        url:    "hocsinhtemplates/dangkylop.php",
        type:   "POST",
        data: {
            username :$username,
            type: $user_type ,
            class_id : $class_id
        }
    }).done(function(data){
        alert(data);
        location.reload();
    });
}