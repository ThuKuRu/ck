function searchdangky(){
    
    $search = $('input[name = "searchbook"]').val();
    $.ajax({
        url: "hocsinhtemplates/dangky.php",
        type: "GET",
        data: {
            search : $search
        }
    }).done(function(data){
        $('.iframe').html(data);
    });
}