var size = 900;
var endpoint = 'http://pale.auspic.es/resize';

module.exports = ({ url, width, height }) => {
  return [
    endpoint,
    (width || size),
    (height || size),
    encodeURIComponent(url)
  ].join('/');
};
