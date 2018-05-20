var ready;
ready = function() {
  M.AutoInit();
  $.each( flashMessages, function(key, value){
    M.toast({html: value, classes: key})
  });
};

// Fire javascript after turbolinks event
$(document).on('turbolinks:load', ready);