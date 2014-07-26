(function($){
  "use strict";

  $.fn.thumbcarousel = function(options){
    var moveActiveToCenter = function(carousel){
      if(carousel.active.size()){

        var prevAllWidth = carousel.active.position().left,
            nextAllWidth = carousel.overview.width() - carousel.active.position().left - carousel.active.outerWidth(),
            centerOffset = (carousel.viewport.width() - carousel.thumbs.outerWidth()) / 2;

        if( prevAllWidth <= centerOffset ){
          carousel.overview.css('left', 0);
        }else if( nextAllWidth <= centerOffset ){
          carousel.overview.css('left', carousel.viewport.width() - carousel.overview.width());
        }else{
          carousel.overview.css('left', -Math.abs(centerOffset - prevAllWidth));
        }
      }
    }

    return this.each(function(){
      var _this = $(this),
          carousel = {
            self:     _this,
            viewport: _this.find('.viewport'),
            overview: _this.find('.overview'),
            prev:     _this.find('.control.prev'),
            next:     _this.find('.control.next'),
            thumbs:   _this.find('li'),
            active:   _this.find('li.active')
          };

      carousel.overview.width(carousel.thumbs.size() * carousel.thumbs.outerWidth());

      carousel.self.on('click', '.control:not(.disable)', function(event) {
        event.preventDefault();
        var $control = $(this),
            leftOffset = carousel.overview.position().left,
            viewWidth  = carousel.viewport.width();
        if(carousel.overview.width() > viewWidth){
          $control.addClass('disable');

          if($control.hasClass('prev')){
            carousel.overview.animate({ left: (viewWidth + leftOffset >= 0) ? 0 : (viewWidth + leftOffset) }, function(){
              $control.removeClass('disable');
            });
          }else{
            var _right = (carousel.overview.width() + leftOffset - viewWidth);
                _right = _right  < viewWidth ? (leftOffset -_right) : (leftOffset - viewWidth);
            carousel.overview.animate({ left: (viewWidth + leftOffset <= 0) ? (carousel.viewport.width() - carousel.overview.width()) : _right }, function(){
              $control.removeClass('disable');
            });
          }
        }
      });

      moveActiveToCenter(carousel);
    });
  }

  $(document).ready(function($) {
    $('[data-toggle="thumb-carousel"]').thumbcarousel();
  });

}(jQuery));
