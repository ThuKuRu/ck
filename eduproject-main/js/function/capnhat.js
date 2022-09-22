function capnhat($mssv,$class_id){
    $username = $('input[name = "usernamecurrent"]').val();
    $user_type = $('input[name ="typecurrent"]').val();
    $giuaky = $("input[name = " + $mssv + "g]").val();
    $cuoiky = $("input[name = " + $mssv + "c]").val();
    $.ajax({
        url:    "giaovientemplates/quanlylop.php",
        type: "POST",
        data:{
            username: $username,
            user_type: $user_type,
            giuaky:$giuaky,
            cuoiky:$cuoiky,
            mssv :$mssv,
            class_id:$class_id
        }
    }).done(function(data){
        $('.iframe').html(data);
    });
}