function huylop($class_id){
    $username = $('input[name = "usernamecurrent"]').val();
    $.ajax({
        url: "hocsinhtemplates/huylop.php",
        type: "POST",
        data:{
            class_id : $class_id,
            username : $username
        }
    }).done(function(data){
        alert(data);
        location.reload();
    });
}