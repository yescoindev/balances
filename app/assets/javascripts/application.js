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

//= require underscore
//= require underscore.string
//= require backbone
//= require backbone.marionette
//= require handlebars.runtime

//= require jquery.ba-dotimeout
//= require js-routes
//= require_tree ./jsqrcode
//= require_tree ./utils

//= require balances
//= require_tree ./models
//= require_tree ./collections
//= require balances_app

//= require_tree ./templates
//= require_tree ./views

$(function(){ $(document).foundation('reveal', {animation: 'fade'}); });

