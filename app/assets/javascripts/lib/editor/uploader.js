var R = require('ramda');
var resize = require('../resize');
var insert = require('../insert');
var tags = require('../tags');

module.exports = {
  bind: function(editor) {
    this.editor = editor;
    this.url = editor.$form.data('upload');
  },

  upload: function(e) {
    e.preventDefault();

    var files = e.originalEvent.dataTransfer.files;

    R.map(R.bind(this.each, this), files);
  },

  dimensions: function (file, callback) {
    var reader = new FileReader();
    reader.onload = function(e) {
      var image = new Image();
      image.onload = function(e) {
          var width = this.width;
          var height = this.height;
          callback(width, height);
      };
      image.src = e.target.result;
    };
    reader.readAsDataURL(file);
  },

  each: function(file) {
    var ctx = this;
    ctx.create(file, function(file, url) {
      ctx.put(file, url, function(url) {
        ctx.dimensions(file, function(width, height) {
          insert(ctx.editor.el, tags.img(resize(url, width, height), file.name));
        });
      });
    });
  },

  put: function(file, url, callback) {
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
  },

  create: function(file, callback) {
    return $.ajax({
      url: this.url,
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
  }
};
