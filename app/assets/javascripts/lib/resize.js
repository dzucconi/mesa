var size = 600;
var endpoint = 'http://pale.auspic.es/resize';

module.exports = function(url, width, height) {
  return [
    endpoint,
    (width || size),
    (height || size),
    encodeURIComponent(url)
  ].join('/');
};
