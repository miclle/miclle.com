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


/* Admin left side menu */
function SDMenu(id) {
  this.menu = $(id)[0];
  this.submenus = $(id).find("li");
  this.remember = true;
  this.speed = 'normal';//"slow", "normal", "fast", number
  this.markCurrent = true;
  this.oneSmOnly = false;
}
SDMenu.prototype.init = function() {
  var mainInstance = this;
  this.submenus.each(function(){
    $(this).find('span').click(function(){
      mainInstance.toggleMenu($(this).parent());
    });
  });
  if (this.remember) {
    var regex = new RegExp("sdmenu_" + encodeURIComponent(this.menu.id) + "=([01]+)");
    var match = regex.exec(document.cookie);
    if (match) {
      var states = match[1].split("");
      for (var i = 0; i < states.length; i++){
        states[i] == 0 ? $(this.submenus[i]).addClass('collapsed') : $(this.submenus[i]).removeClass('collapsed');
      }
    }
  }
  if (this.markCurrent) {
    $(this.menu).find('a').each(function(){
      if (this.href == document.location.href || document.location.href.search(this.href) >= 0) {
        $(this).addClass("active").parents('li').addClass("active").removeClass('collapsed');
      }
    });
  }
};
SDMenu.prototype.toggleMenu = function(submenu) {
  $(submenu).hasClass("collapsed") ? this.expandMenu(submenu) : this.collapseMenu(submenu);
};
SDMenu.prototype.expandMenu = function(submenu) {
  var mainInstance = this;
  $(submenu).find('div').slideDown(this.speed, function(){
    $(submenu).removeClass("collapsed");
    mainInstance.memorize();
  });
  this.collapseOthers(submenu);
};
SDMenu.prototype.collapseMenu = function(submenu) {
  var mainInstance = this;
  $(submenu).find('div').slideUp(this.speed, function(){
    $(submenu).addClass("collapsed");
    mainInstance.memorize();
  });
};
SDMenu.prototype.collapseOthers = function(submenu) {
  if (this.oneSmOnly) {
    for (var i = 0; i < this.submenus.length; i++){
      if (this.submenus[i] != submenu && !$(this.submenus[i]).hasClass("collapsed")){
        this.collapseMenu(this.submenus[i]);
      }
    }
  }
};
SDMenu.prototype.expandAll = function() {
  var oldOneSmOnly = this.oneSmOnly;
  this.oneSmOnly = false;
  for (var i = 0; i < this.submenus.length; i++){
    if ($(this.submenus[i]).hasClass("collapsed")){
      this.expandMenu(this.submenus[i]);
    }
  }
  this.oneSmOnly = oldOneSmOnly;
};
SDMenu.prototype.collapseAll = function() {
  for (var i = 0; i < this.submenus.length; i++){
    if (!$(this.submenus[i]).hasClass("collapsed")){
      this.collapseMenu(this.submenus[i]);
    }
  }
};
SDMenu.prototype.memorize = function() {
  if (this.remember) {
    var states = new Array();
    for (var i = 0; i < this.submenus.length; i++){
      states.push($(this.submenus[i]).hasClass("collapsed") ? 0 : 1);
    }
    var d = new Date();
    d.setTime(d.getTime() + (30 * 24 * 60 * 60 * 1000));
    document.cookie = "sdmenu_" + encodeURIComponent(this.menu.id) + "=" + states.join("") + "; expires=" + d.toGMTString() + "; path=/";
  }
};
/* Admin left side menu end */

$(function() {

  setTimeout(function(){ $('#notice').fadeOut() }, 1000*3);

  var sideMenu = new SDMenu("#sidemenu");
      sideMenu.init();

  $('#expand-all').click(function(){sideMenu.expandAll()});
  $('#collapse-all').click(function(){sideMenu.collapseAll()});
  $('#one-menu-only').click(function(){
    sideMenu.oneSmOnly = $(this).is(':checked') ? true : false;
    var d = new Date();
    d.setTime(d.getTime() + (30 * 24 * 60 * 60 * 1000));
    document.cookie = "sdmenu_oneSmOnly=" + (sideMenu.oneSmOnly ? 1 : 0) + "; expires=" + d.toGMTString() + "; path=/";
  });

  var regex = new RegExp("sdmenu_oneSmOnly=([01]+)");
  var match = regex.exec(document.cookie);
  if(match != null && match[1] != null && match[1] - 0 == 1){
    $('#one-menu-only').attr("checked", true);
    sideMenu.oneSmOnly = true;
  }
  // End Sidemenu

  $('.ui.sidebar').sidebar('show');

  $('.ui.checkbox').checkbox();
  $('.ui.dropdown').dropdown();
  $('.ui.modal').modal();

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

  // 切换左边栏导航菜单
  $(document).on('click', '.ui.black.left.attached.item', function(event) {
    event.preventDefault();
    /* Act on the event */
    $('.ui.sidebar').sidebar('toggle');
  });


  key('left', function(){
    $('a.previous').get(0).click();
  });

  key('right', function(){
    $('a.next').get(0).click();
  });


});