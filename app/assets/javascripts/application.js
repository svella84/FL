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
//= require foundation

$(function(){ $(document).foundation({
  orbit: {
    animation: 'slide', // Sets the type of animation used for transitioning between slides
    timer_speed: 10000,
    pause_on_hover: true, // Pauses on the current slide while hovering
    resume_on_mouseout: true,
    animation_speed: 500,
    navigation_arrows: true,
    bullets: false, // Does the slider have bullets visible?
    swipe: true,
  }
}); });

//= require turbolinks
//= require_tree .

