window.jQuery = window.$ = require('jquery');
require('jquery-ujs');

var Selection = require('selection.js');
var insert = require('./lib/insert');
var Mousetrap = require('mousetrap');

$(function(){
  'use strict';

  var $editor = $('#page_content');

  if (!$editor.length) return;

  var editor = {
    $el: $editor,
    el: $editor[0],
    key: new Mousetrap($editor[0]),
    sel: new Selection($editor)
  };

  editor.key.bind('command+s', function(e) {
    e.preventDefault();
    $('#edit_page_1').submit();
  });

  editor.key.bind('tab', function(e) {
    e.preventDefault();
    insert(editor.el, '  ');
  });

});
