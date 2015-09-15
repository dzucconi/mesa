var bind = require('./bindings');
var uploader = require('./uploader');

module.exports = function() {
  'use strict';

  var editor = {
    el: $('.js-editor')[0],
    $el: $('.js-editor'),
    $form: $('.js-form')
  };

  bind(editor);

  uploader.bind(editor);
  editor.$el.on('drop', uploader.upload.bind(uploader));

  return editor;
};
