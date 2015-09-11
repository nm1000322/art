$("#menu").click(function() {
  $('.ui.sidebar')
      .sidebar('toggle')
  ;
    })


$("#login").click(function() {
  $('.ui.modal')
      .modal('show')
  ;
})

$("#addimage").click(function() {
  $('.ui.modal')
      .modal('show')
  ;
})

/*
function homepage(){
  $('div#sections section').hide();
  $('section#homepage').show();
}
function about(){
  $('div#sections section').hide();
  $('section#about').show();
}
function gallery(){
  $('div#sections section').hide();
  $('section#gallery').show();
}
page('/', homepage);
page('/about', about);
page('/gallery', gallery);
page();
*/
