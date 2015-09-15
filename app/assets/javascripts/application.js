window.jQuery = window.$ = require('jquery');
require('jquery-ujs');

var views = {
  pages_show: require('./views/pages_show'),
  pages_edit: require('./views/pages_edit')
};

$(function(){
  'use strict';

  var current = $('body').data().view;
  var view = views[current];

  if (view) view();
});
