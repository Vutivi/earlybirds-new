// const client = algoliasearch('4EYDS3XWBL', '429d8c35a18e44144521e8f9dd27227c');
// const index = client.initIndex('Trip');

$(document).on('click','.search-button', function() {
    searchValue = $('#search-box').val();
    location.replace('/trips/search/' + searchValue.split(' ').join('-') )
});

$(document).on('keypress','#search-box',function(e) {
    if(e.which == 13) {
        searchValue = $(this).val();
        location.replace('/trips/search/' + searchValue.split(' ').join('-') )
    }
});