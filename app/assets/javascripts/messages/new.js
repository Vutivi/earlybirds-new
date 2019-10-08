// $(document).on('click', '.trip-message-sending', function(){
//     tripId     = $(this).attr('data-trip-id');
//     userId     = $(this).attr('data-user-id');
//     body       = $('#body').val();

//     $.ajax({
//         url: '/messages',
//         type:  'POST',
//         dataType: 'json',
//         data: {message: 
//                 {
//                     trip_id: tripId,
//                     user_id: userId,
//                     body: body
//                 }
//         },
//         success: function(res) {
//             toastr.success('Message succesfully sent.');
//         },
//         error: function(res) {
//             toastr.error(res['responseText']);
//         }
//     });
// })
