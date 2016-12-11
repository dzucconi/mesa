var size = 900;
var endpoint = window.BOOTSTRAP.env.PROXY_ENDPOINT;

module.exports = ({ url, width, height }) => {
  return [
    endpoint,
    (width || size),
    (height || size),
    encodeURIComponent(url)
  ].join('/');
};
