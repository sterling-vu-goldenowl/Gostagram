// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks

//= require jquery
//= require bootstrap-sprockets

//= require_tree .

$(document).ready(function(){
  $(window).scroll(function() {
    if ($(document).scrollTop() > 80) {
      $("div.header-line").style.display = 'none';
      $("div.ins-logo")..style.display = 'none';
      $('header').addClass('scroll-header');
    } else {
      $("div.header-line")..style.display = 'inline-block';
      $("div.ins-logo")..style.display = 'inline-block';
      $('header').removeClass('scroll-header');
    }
  });

  var btnContainer = document.getElementById("edit-left-menu");
  var btns = btnContainer.getElementsByClassName("edit-tab");
  for (var i = 0; i < btns.length; i++) {
    btns[i].addEventListener("click", function() {
      var current = document.getElementsByClassName("active");
      current[0].className = current[0].className.replace(" active", "");
      this.className += " active";
    });
  }
});
