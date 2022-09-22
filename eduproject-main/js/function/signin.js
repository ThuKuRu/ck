$('#submit_signin').on('click', function() {
	$user_signin = $('#user_signin').val();
	$pass_signin = $('#pass_signin').val();
    $typesignin = $('#formSignin input[name="typeaccount"]:checked').val();
    if ($user_signin == '' || $pass_signin == '')
    {
        $('#formSignin .alert').removeClass('hidden');
        $('#formSignin .alert').html('Vui lòng điền đầy đủ thông tin bên trên.');
    }
    else{
        $.ajax({
            url:  'signin.php',
            type: 'POST',
            data: {
                user_signin : $user_signin,
				pass_signin : $pass_signin,
                typesignin : $typesignin
            }
        }).done(function(data){
                $('#formSignin .alert').removeClass('hidden');
                $('#formSignin .alert').html(data);
                
        });
    }
});