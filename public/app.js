$(document).ready(function(){

  var li;

  $(document).on('click', '#button', function(){
    $.ajax({
      type: 'POST',
      url: '/'
    }).done(function(){
     li =  $("add_item textarea").html()
      ;
    });
    return false;
  });
});