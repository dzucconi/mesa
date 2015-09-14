module.exports = {
  img: function(url, title) {
    return '![' + (title || '') + '](' + url + ')';
  }
};
