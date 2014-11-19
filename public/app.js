$(document).ready(function(){

$("#ajaxTarget").on('click', '#flag, #priority', function(){
  var id = $(this).data("id");
  $.post('/'+id+'/flag', function(data){
    $("#indicate"+id).html(data)
  });
});

$("#editajaxTarget").on('click', '#flag, #priority', function(event){
  event.preventDefault();
  var id = $(this).data("id");
  $.post('/'+id+'/flag', function(data){
    $("#editajaxTarget #indicate"+id).html(data)
  });
});
$("#add").on('click','#button', function(e){
  e.preventDefault();
  $.ajax('/', {
    type: 'POST',
    data: {"content": $("#text-data").val()},
    success: function(response){
      alert(response);
      $("#ajaxTarget").append(response);
      $("#text-data").val("");
    }
    // $('#ajaxTarget').append(data);
  });

});

  // $('#filters').on('click', '.priority-filter', function(){
  //     //filter out impoortant items
  //     $('#ajaxTarget').filter('#priority');
  // });

  // $('#filters').on('click', '.all-filter', function(){
  //     //filter out impoortant items
  //     $('#ajaxTarget').filter('#priority');
  // });

});