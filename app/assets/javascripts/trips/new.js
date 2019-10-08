$(document).on('turbolinks:load', function(){

    $(document).on('click', '#round_trip', function(){
        var checkBox = document.getElementById("round_trip");
        if(checkBox.checked == false){
            $('.trip_return_times').css('display', 'block');
        }else{
            $('.trip_return_times').css('display', 'none');
        }
    });

    $(document).on('change', '#trip_kind', function(){
        if(this.value == 'social_events'){
            $('.trip_event').css('display', 'block');
        }else{
            $('.trip_event').css('display', 'none');
        }
    })
})