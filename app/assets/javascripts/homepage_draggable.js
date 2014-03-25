// Fun:  Making the spinning divs draggable
  $(function() {
    $( ".draggable" ).draggable({ axis: "y" });
  });

// Expand Panel for Login
$(".subtitle1-button").click(function() 
  {
    $('#sign_up').slideToggle('slow');
  });

// Expand Panel for Sign Up
$(".subtitle2-button").click(function()
  {
    $('#login').slideToggle('slow');
  });
