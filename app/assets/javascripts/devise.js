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

// semantic-ui/accordion
// semantic-ui/chatroom

//= require semantic-ui/checkbox

// semantic-ui/dimmer
// semantic-ui/dropdown
// semantic-ui/modal
// semantic-ui/nag
//= require semantic-ui/popup
// semantic-ui/rating
// semantic-ui/search
// semantic-ui/shape
// semantic-ui/sidebar
// semantic-ui/tab
//= require semantic-ui/transition
// semantic-ui/video
// semantic-ui/behavior/api
// semantic-ui/behavior/colorize
// semantic-ui/behavior/form
// semantic-ui/behavior/state

$(function () {

  $('input.popup').popup({on: 'focus'});

  var stripesScrollSpeed = 20;

  //function to animate the stripes
  var scrollStripes = function () {
    var current = 0;
    //Calls the scrolling function repeatedly
    var init = setInterval(function () {
      // 1 pixel row at a time
      current -= 1;
      // move the background with backgrond-position css properties
      $('.subscribe .stripes').css("backgroundPosition", current+"px 0");
    }, stripesScrollSpeed);
  }

  $('.subscribe').on('submit', 'form', function(event) {
    // event.preventDefault();
    $('.subscribe input[type=text]').removeClass('error');
    scrollStripes();
  });

  // //hook up click event to submit button
  // $('.subscribe button.submit').click(function () {
  //   //clear all errors
  //   $('.subscribe input[type=text]').removeClass('error');
  //   custom.scrollStripes
  //   return false;
  // });

});
