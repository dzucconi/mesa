var Mousetrap = require('mousetrap');

module.exports = function() {
  Mousetrap.bind('e', function(e) {
    window.location = $('.js-page-edit').attr('href');
  });
};
