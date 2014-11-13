$(document).ready(function(){

$("#ajaxTarget").on('click', '#flag, #priority', function(){
  var id = $(this).data("id");
  $.post('/'+id+'/flag', function(data){
    $("#indicate"+id).html(data)
  });
});

$("#editajaxTarget").on('click', '#flag, #priority', function(){
  var id = $(this).data("id");
  $.post('/'+id+'/flag', function(data){
    $("#editajaxTarget #indicate"+id).html(data)
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