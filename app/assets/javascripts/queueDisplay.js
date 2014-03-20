var getQueue = function(){
  $.getJSON('/getqueue', function(response){
    console.log(response);
  });
};