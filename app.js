$(document).ready(function(){
  $('#left-arrow').on('click', function(){
    showSlide('prev')
  });
  $('#right-arrow').on('click', function(){
    showSlide('next')
  });
});

var getCurrent = function(){
  return $('.img.display-me').data('id')
}

var hideCurrent = function(){
  $('.img.display-me').removeClass('display-me')
                      .addClass('hide-me');
}

var showSlide = function(type){
  var n;

  if (type == 'prev'){
    n = getCurrent() - 1;
    if( n==0 ){ n=5 }
  }
  else if(type == 'next'){
    n = getCurrent() + 1;
    if( n==6 ){ n=1 }
  }

  hideCurrent();
  $('[data-id="'+n+'"]').addClass('display-me');
}
