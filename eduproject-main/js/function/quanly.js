function quanlylop($class_id){
    $.ajax({
        url: "giaovientemplates/quanlylop.php",
        type: "POST",
        data:{
            class_id : $class_id 
        }
    }).done(function(data){
        $('.iframe').html(data);
    });
}