$("#gvif").click(function() {
    $username = $('input[name = "usernamecurrent"]').val();
    $user_type = $('input[name ="typecurrent"]').val();
    $.ajax({
        url:  'giaovientemplates/giaovieninfo.php',
        type: 'POST',
        data: {
            username: $username,
            user_type: $user_type
        }
    }).done((data) => {
            $('.iframe').html(data);

        });
});

$('#giaovieninfo').click(function() {
    $username = $('input[name = "usernamecurrent"]').val();
    $user_type = $('input[name ="typecurrent"]').val();
    $.ajax({
        url:  'giaovientemplates/giaovieninfo.php',
        type: 'POST',
        data: {
            username: $username,
            user_type: $user_type
        }
    }).done((data) => {
            $('.iframe').html(data);
        });
});

$('#giaovientkb').click(function() {
    $username = $('input[name = "usernamecurrent"]').val();
    $user_type = $('input[name ="typecurrent"]').val();
    $.ajax({
        url:  'giaovientemplates/giaovientkb.php',
        type: 'POST',
        data: {
            username: $username,
            user_type: $user_type
        }
    }).done((data) => {
            $('.iframe').html(data);

        });
});
$('#quanly').click(function() {
    $username = $('input[name = "usernamecurrent"]').val();
    $user_type = $('input[name ="typecurrent"]').val();
    $.ajax({
        url:  'giaovientemplates/quanly.php',
        type: 'POST',
        data: {
            username: $username,
            user_type: $user_type
        }
    }).done((data) => {
            $('.iframe').html(data);

        });
});
$('#taolophoc').click(function() {
    $username = $('input[name = "usernamecurrent"]').val();
    $user_type = $('input[name ="typecurrent"]').val();
    
    $.ajax({
        url:  'giaovientemplates/taolophoc_form.php',
        type: 'POST',
        data: {
            username: $username,
            user_type: $user_type
        }
    }).done((data) => {
            $('.iframe').html(data);

        });
});