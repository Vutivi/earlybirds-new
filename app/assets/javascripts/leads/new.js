$(document).on('click', '.leads-form', function(){
    firstName = $('#first_name').val();
    lastName  = $('#last_name').val();
    cellphone = $('#cellphone').val();
    email     = $('#email').val();
    tripId    = $('#trip_id').val();

    $.ajax({
        url: '/leads',
        contentType: 'json',
        type: 'POST',
        data: {
            lead: {
                first_name: first_name,
                last_name: lastName,
                cellphone: cellphone,
                email: email,
                trip_id: tripId
            }
        },
        success: function(res) {
            toastr.success(res.responseText);
            setTimeout(function(){// wait for 2 secs(2)
                location.reload(); // then reload the page.(3)
            }, 1000); 
        },
        error: function(res) {
            toastr.alert(res.responseText);
        }
    });

});