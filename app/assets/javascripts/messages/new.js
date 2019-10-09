$(document).on('click', '.trip-message-sending', function(){
    tripId     = $(this).attr('data-trip-id');
    userId     = $(this).attr('data-user-id');
    body       = $('#body').val();
    
    $.ajax({
        url: '/messages',
        type:  'POST',
        dataType: 'json',
        data: {message: 
                {
                    trip_id: tripId,
                    user_id: userId,
                    body: body
                }, 
                format: 'json'
        },
        success: function(res) {
            toastr.success('Message succesfully sent');
            var dateTime = new Date();
            var ampm     = (dateTime.getMonth >= 12) ? "AM" : "PM";

            $('.write_msg').val("");
            $('.msg_history').append(`<div class="outgoing_msg">
            <div class="sent_msg">
              <p>`+ body +`</p>
              <span class="time_date">`+ dateTime.getHours() +`:`+ dateTime.getMinutes() + ' '+ ampm +' | ' + dateTime.getDay() + ` ` + dateTime.toLocaleString('default', { month: 'long' }) +`</span>
              </div>
            </div>`);
            $('.msg_history').scrollTop($('.msg_history')[0].scrollHeight);
        },
        error: function(res) {
            toastr.error(res['responseText']);
        }
    });
})

$(document).on('click', '.chat_people', function(){
    $('.msg_history').empty();
    $('.type_msg').empty();

    var tripId = $(this).attr('data-trip-id');
    var userId = $(this).attr('data-user-id');

    $.ajax({
        url: '/messages/trip/' + tripId,
        type: 'GET',
        dataType: 'json', 
        success: function(res) {
            $.each(res, function (i, message) {
                render(message)
            });
            $('.type_msg').append(`
                <div class="input_msg_write">
                    <input type="text" class="write_msg" placeholder="Type a message" id="body" />
                    <button class="msg_send_btn trip-message-sending" type="button" data-trip-id="`+ tripId +`" data-user-id="`+ userId +`"><i class="fa fa-paper-plane-o" aria-hidden="true"></i></button>
                </div>
            `);
        },
        error: function(res) {
            toastr.error(res['responseText']);
        }
    })
});

function render(res){
    if(res.owner == true){
        $('.msg_history').append(`<div class="outgoing_msg">
        <div class="sent_msg">
          <p>`+ res.body +`</p>
          <span class="time_date">`+ res.created_at_time +` | `+ res.created_at_date +`</span>
          </div>
        </div>`);
    }else if(res.owner == false){
        $('.msg_history').append(`<div class="incoming_msg">
        <h5>`+ res.sender_name +`</h5>
        <div class="received_msg">
          <div class="received_withd_msg">
            <p>`+ res.body +`</p>
            <span class="time_date">`+ res.created_at_time +` | `+ res.created_at_date +`</span>
          </div>
        </div>
      </div>`);
    }
}
