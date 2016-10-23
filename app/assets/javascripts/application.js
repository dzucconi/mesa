window.jQuery = window.$ = require('jquery');
require('jquery-ujs');

$(function(){
  'use strict';

  const editor = require('./lib/editor')();
  require('./lib/uploader')(editor);

  window.editor = editor;
});
