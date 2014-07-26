// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs

//= require semantic-ui
//= require rails-timeago
//= require jquery.lazyload.min

//= require jquery.qrcode.min
//= require social-share-button
//= require keymaster

// 1999:12:31 14:00:00 => 1999-12-31 14:00:00
var parseExifDateTimeOriginal = function (string) {
  if(string == null || string == undefined || /^\s*$/.test(string))
    return;
  var datetime = string.split(" ");
  return datetime[0].replace(/:/g,"-") + " " + datetime[1];
}

/**
 * GPS Value to Number
 * Ref | GPS Value      | Result
 * ----|----------------|------------
 *  N  | [51, 59.37, 0] | 51.9895
 *  W  | [ 1, 40.96, 0] | -1.68266667
 */
var GPSToNUM = function (ref, degrees) {
  if(degrees == undefined)
    return;
  return (degrees[0] + (degrees[1] + degrees[2] / 60) / 60) * ((ref == "S" || ref == "W") ? -1 : 1)
}

// Format file size
var formatFileSize = function (bytes) {
  if (typeof bytes !== 'number') {
    return '';
  }
  if (bytes >= 1000000000) {
    return (bytes / 1000000000).toFixed(2) + ' GB';
  }
  if (bytes >= 1000000) {
    return (bytes / 1000000).toFixed(2) + ' MB';
  }
  return (bytes / 1000).toFixed(2) + ' KB';
}

// Format file name, eg. abc.jpg => abc
var formatFileName = function(string){
  return string.slice(0, string.lastIndexOf('.'));
}

// Simplified Chinese
jQuery.timeago.settings.strings["zh-CN"] = {
  prefixAgo: null,
  prefixFromNow: "刚刚",
  suffixAgo: "之前",
  suffixFromNow: null,
  seconds: "不到1分钟",
  minute: "1分钟",
  minutes: "%d分钟",
  hour: "1小时",
  hours: "%d小时",
  day: "1天",
  days: "%d天",
  month: "1个月",
  months: "%d月",
  year: "1年",
  years: "%d年",
  numbers: [],
  wordSeparator: ""
};

(function($) {
  /**
   * jQuery UUID plugin 1.0.0
   *
   * @author Eugene Burtsev
   * https://github.com/eburtsev/jquery-uuid
   * eg. $.uuid() => "74445d13-c1a8-4dac-a97f-5a82d23033e2"
   */
  $.uuid = function() {
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
      var r = Math.random()*16|0, v = c == 'x' ? r : (r&0x3|0x8);
      return v.toString(16);
    });
  };

  /**
   *
   * 'data-uuid' attribute contains the elements will be found
   * eg. $uuid("08ce4aed-7a5b-4da0-aab0-cbcaf58432b6") => [...]
   */
  $uuid = function(uuid){
    return $('[data-uuid="'+uuid+'"]');
  }
})(jQuery);


$(function(){

  // over text
  // <a href="/painters/1/unfollow" data-over="取消关注" data-remote="true">已关注</a>
  // <a href="/u/2/unfollow" data-over="取消关注">已关注</a>

  $(document).on('mouseover', '[data-over]', function() {
    var $element = $(this);
        $element.data('original', $element.html()).html($element.attr('data-over'));
  });

  $(document).on('mouseout', '[data-over]', function() {
    var $element = $(this);
        $element.html($element.data('original'));
  });

  // // DR Code
  // $('[data-dr-code]').each(function(index, el) {
  //   var _this = $(this);
  //   _this.qrcode({
  //     width   : _this.attr('data-dr-size') || 64,
  //     height  : _this.attr('data-dr-size') || 64,
  //     text    : _this.attr('data-dr-code')
  //   });
  // });

  $('.ui.checkbox').checkbox();
  $('.ui.dropdown').dropdown();
  // $('.ui.modal').modal();

  // Photo lazy load
  $(".artwork .preview img").lazyload();
  $('img[lazyload]').lazyload();

  // selector cache
  var
    $buttons = $('.ui.buttons .button'),
    $toggle  = $('.main .ui.toggle.button'),
    $button  = $('.ui.button').not($buttons).not($toggle),
    // alias
    handler = {
      activate: function() {
        $(this).addClass('active').siblings().removeClass('active');
      }
    };

  // $buttons.on('click', handler.activate);

  $toggle.state({text: {inactive : 'Vote', active   : 'Voted'}});

  $('input.popup').popup({on: 'focus'});

  $('.tabs').on('click', '[data-toggle="tab"]', function(event) {
    event.preventDefault();
    var tab = $(this);
    tab.addClass('active').siblings().removeClass('active');
    $(tab.attr('href')).show().siblings().hide();
  });

});