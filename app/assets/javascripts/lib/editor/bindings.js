var Mousetrap = require('mousetrap');
var insert = require('../insert');

module.exports = function(editor) {
  'use strict';

  var keyboard = new Mousetrap(editor.el);

  // Save in place
  keyboard.bind('command+s', function(e) {
    e.preventDefault();
    editor.$el.css('cursor', 'progress');
    $.ajax({
      method: 'PUT',
      url: editor.$form.attr('action'),
      data: editor.$form.serialize(),
      success: function() {
        // Ensure the indicator stays on screen at least 250ms
        setTimeout(function() {
          editor.$el.css('cursor', 'default');
        }, 250);
      }
    });
  });

  // Save and redirect
  keyboard.bind('command+shift+s', function(e) {
    e.preventDefault();
    editor.$form.submit();
  });

  // Insert two spaces
  keyboard.bind('tab', function(e) {
    e.preventDefault();
    insert(editor.el, '  ');
  });
};
