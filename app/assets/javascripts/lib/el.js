const $ = require('jquery');

module.exports = selector => {
  const $el = $(selector);

  if (!$el.length) return false;

  return {
    selector,
    $el,
  };
};
