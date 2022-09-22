$('#hocsinhinfo').click(function() {
    $username = $('input[name = "usernamecurrent"]').val();
    $user_type = $('input[name ="typecurrent"]').val();
    $.ajax({
        url:  'hocsinhtemplates/hocsinhinfo.php',
        type: 'POST',
        data: {
            username: $username,
            user_type: $user_type
        }
    }).done(function(data){
            $('.iframe').html(data);
            
    });
});
$('#tkb').click(function() {
    $username = $('input[name = "usernamecurrent"]').val();
    $user_type = $('input[name ="typecurrent"]').val();
    $.ajax({
        url:  'hocsinhtemplates/showtkb.php',
        type: 'POST',
        data: {
            username: $username,
            user_type: $user_type
        }
    }).done(function(data){
            $('.iframe').html(data);
            
    });
});
$('#dangky').click(function() {
    $username = $('input[name = "usernamecurrent"]').val();
    $user_type = $('input[name ="typecurrent"]').val();
    $.ajax({
        url:  'hocsinhtemplates/dangky.php',
        type: 'POST',
        data: {
            username: $username,
            user_type: $user_type
        }
    }).done(function(data){
            $('.iframe').html(data);
            
    });
});
$('#bangdiem').click(function() {
    $username = $('input[name = "usernamecurrent"]').val();
    $user_type = $('input[name ="typecurrent"]').val();
    $.ajax({
        url:  'hocsinhtemplates/bangdiemcanhan.php',
        type: 'POST',
        data: {
            username: $username,
            user_type: $user_type
        }
    }).done(function(data){
            $('.iframe').html(data);
            
    });
});

