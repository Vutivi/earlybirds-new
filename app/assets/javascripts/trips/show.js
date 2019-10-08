
$(document).on('click', '.join-trip', function(){
    tripId     = $(this).attr('data-trip-id');
    userId     = $(this).attr('data-user-id');
    actionType = $(this).attr('data-action-type');
    riderId    = $(this).attr('data-rider-id');
    
    if(actionType == 'Join'){
        $.ajax({
            url: '/riders',
            type:  'POST',
            dataType: 'json',
            data: {rider: 
                    {
                        trip_id: tripId,
                        user_id: userId
                    }
            },
            success: function(res) {
                toastr.success('Succesfully joined this trip');

                setTimeout(function(){// wait for 2 secs(2)
                    location.reload(); // then reload the page.(3)
                }, 1000); 
            },
            error: function(res) {
                toastr.error(res['responseText']);
            }
        });
    }else if(actionType == 'Leave'){
        $.ajax({
            url: '/riders/' + riderId,
            type:  'DELETE',
            dataType: 'json',
            success: function(res) {
                toastr.success('Succesfully left this trip');

                setTimeout(function(){// wait for 2 secs(2)
                    location.reload(); // then reload the page.(3)
                }, 1000); 
            },
            error: function(res) {
                toastr.error(res['responseText']);
            }
        });
    }
})
