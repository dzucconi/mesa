window.jQuery = window.$ = require('jquery');
require('jquery-ujs');

var Selection = require('selection.js');
var insert = require('./lib/insert');
var Mousetrap = require('mousetrap');

var tags = require('./lib/tags');
var resize = require('./lib/resize');

$(function(){
  'use strict';

  var $editor = $('#page_content');
  var $form = $('.edit_page');

  if (!$editor.length) return;

  var editor = {
    $el: $editor,
    el: $editor[0],
    key: new Mousetrap($editor[0]),
    sel: new Selection($editor)
  };

  editor.key.bind('command+s', function(e) {
    e.preventDefault();
    $form.submit();
  });

  editor.key.bind('tab', function(e) {
    e.preventDefault();
    insert(editor.el, '  ');
  });

  var uploads = {
    url: window.location.pathname.replace(/edit$/, 'uploads'),

    create: function(file, callback) {
      return $.ajax({
        url: uploads.url,
        method: 'POST',
        data: { upload: {
          file_name: file.name,
          file_size: file.size,
          content_type: file.type
        }},
        success: function(response) {
          file.url = response.get;
          callback(file, response.put);
        }
      });
    },
    upload: function(file, url, callback) {
      return $.ajax({
        url: url,
        data: file,
        type: 'PUT',
        processData: false,
        contentType: false,
        success: function() {
          callback(file.url);
        },
        error: console.error.bind(console)
      });
    }
  };

  $editor.on('drop', function(e) {
    e.preventDefault();

    var files = e.originalEvent.dataTransfer.files;

    for (var i = files.length - 1; i >= 0; i--) {
      var file = files[i];
      uploads.create(file, function(file, url) {
        uploads.upload(file, url, function(url) {
          insert(editor.el, tags.img(resize(url), file.name));
        });
      });
    }
  });

});
