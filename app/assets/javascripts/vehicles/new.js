$(document).on('turbolinks:load', function(){
   fillMakes();
   $(document).on('change', '#vehicle_make', function(){
      var vehicleMake = this.value;
      vehicleMake     = /\s/.test(vehicleMake) ? vehicleMake.split(' ').join('%20') : vehicleMake
      fillModels(vehicleMake)
   })

   function fillMakes(){
      var $select = $('#vehicle_make');  
      $select.find('option').remove(); 

      $.ajax({
         dataType: 'json',
         url: 'https://vpic.nhtsa.dot.gov/api/vehicles/GetAllMakes?format=json',
         // url: 'https://www.carqueryapi.com/api/0.3/?callback=?&cmd=getMakes',
         success: function(res) {
            // for carquery
            // makes = $.map( res['Makes'], function( n ) {
            //    return n['make_display'];
            // });

            // for vpic
            makes = $.map( res['Results'], function(n){
               return n['Make_Name'];
            });

            $.each(makes, function(key, value) {              
               $select.append('<option value=' + value + '>' + value + '</option>');
            });    
         },
         error: function(res) {
            toastr.error('Cars api did not find any makes');
         }
      });
   }

   function fillModels(make){
      var $select = $('#vehicle_model');  
      $select.find('option').remove(); 

      $.ajax({
         url: 'https://www.carqueryapi.com/api/0.3/?callback=?&cmd=getModels&make='+ make,
         dataType: 'json',
         success: function(res) {
            models = $.map( res['Models'], function( n ) {
               return n['model_name'];
            });

            $.each(models, function(key, value) {              
               $select.append('<option value=' + value + '>' + value + '</option>');
            });   
         },
         error: function(res) {
            toastr.error('Cars api did not find any models');
         }
      });
                                           
   }

   
   
})