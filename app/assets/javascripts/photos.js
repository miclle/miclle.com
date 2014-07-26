//= require jquery.thumbcarousel

$(function(){

  // Photo show light box
  $('body').dimmer({
    transition: 'fade 0',
    onShow: function(){
      $('#light-box-open').hide();
      $('#light-box-close').show();
    },
    onHide: function(){
      $('#light-box-open').show();
      $('#light-box-close').hide();
    }
  });

  $('#light-box-open').click(function(event) {
    $('body').dimmer('show');
  });

  $('#light-box-close').click(function(event) {
    $('body').dimmer('hide');
  });

  key('h', function(){
    console.log($('body').dimmer('toggle'));
  });

  key('esc', function(){
    $('body').dimmer('hide');
  });

  //
  var $active = $('.thumb-carousel li.active');
  var $prev   = $active.prev(),
      $next   = $active.next();

  key('left', function(){
    $prev.size() && $prev.find('a').get(0).click();
  });

  key('right', function(){
    $next.size() && $next.find('a').get(0).click();
  });

  key('l', function(){
    $('#like-button').get(0).click();
  });

  key('f', function(){
    $('#favorite-button').get(0).click();
  });

});