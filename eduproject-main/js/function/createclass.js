function createlop () {
    $username = $('input[name = "usernamecurrent"]').val();
    $user_type = $('input[name ="typecurrent"]').val();
    $thu = $('#thu').val();
    $time = $('input[name ="usr_time"]').val();
    $lop = $("#lophoc :selected").val();
    $mon = $("#mon :selected").val();
    $.ajax({
        url:    "giaovientemplates/createclass.php",
        type: "POST",
        data: {
            username:$username,
            type : $user_type,
            thu: $thu,
            time: $time,
            lop: $lop,
            mon: $mon
        }
    }).done((data) => {
            alert(data);
        });
};