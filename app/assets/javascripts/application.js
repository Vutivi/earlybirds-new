//= require jquery
//= require bootstrap-sprockets
//= require jquery.slick
//= require toastr
//= require social-share-button
//= require rails-ujs
//= require turbolinks
//= require_tree .

$(document).on('turbolinks:load', function() {
  $(function () {
    $("select").select2();
  });


  $(() => {

    const box = $('.box'),
          ph = $('.box-placeholder');
          
    let toggleEffect = () => {
      box.hide();
      ph.show();
      
      setTimeout(() => {
        ph.hide();
        box.show();
      }, 2e3);
    };
  
    toggleEffect();
    
    setInterval(toggleEffect, 4e3);
  
  });
    
  $('.responsive').slick({
        dots: true,
        infinite: false,
        speed: 300,
        slidesToShow: 3,
        slidesToScroll: 3,
        arrows: true,
        responsive: [
          {
            breakpoint: 1024,
            settings: {
              slidesToShow: 3,
              slidesToScroll: 3,
              infinite: true,
              dots: true
            }
          },
          {
            breakpoint: 600,
            settings: {
              slidesToShow: 2,
              slidesToScroll: 2
            }
          },
          {
            breakpoint: 480,
            settings: {
              slidesToShow: 1,
              slidesToScroll: 1
            }
          }
          // You can unslick at a given breakpoint now by adding:
          // settings: "unslick"
          // instead of a settings object
        ]
      });

      // $('#modalAurhenticateForm').modal('show')

      (function() {
        var placesAutocomplete = places({
          appId: 'pl9QGD4SW1M6',
          apiKey: '3bd7b86d873e747da25a647e1fcb8ffb',
          language: 'en',
          countries: ['za'],
          type: 'address',
          aroundLatLngViaIP: false,
          container: document.querySelector('#trip_start_location')
        });
      
        // var $address = document.querySelector('#start_address-value')
        placesAutocomplete.on('change', function(e) {
          $address.textContent = e.suggestion.value
        });
      
        placesAutocomplete.on('clear', function() {
          $address.textContent = 'none';
        });
      
      })();
      
      (function() {
        var placesAutocomplete = places({
          appId: 'pl9QGD4SW1M6',
          apiKey: '3bd7b86d873e747da25a647e1fcb8ffb',
          language: 'en',
          countries: ['za'],
          type: 'address',
          aroundLatLngViaIP: false,
          container: document.querySelector('#trip_end_location')
        });
      
        // var $address = document.querySelector('#address-value')
        placesAutocomplete.on('change', function(e) {
          $address.textContent = e.suggestion.value
        });
      
        placesAutocomplete.on('clear', function() {
          $address.textContent = 'none';
        });
      
      })();

});
