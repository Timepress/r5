var ready;
ready = function() {
  $.each( flashMessages, function(key, value){
    $.snackbar({content: value, style: key, timeout: 5000});
  });
};

// Fire javascript after turbolinks event
$(document).on('turbolinks:load', ready);