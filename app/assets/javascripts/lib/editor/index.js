const el = require('../el');

const STATE = {
  is: {
    edited: false,
    saving: false,
  },
};

const MODES = {
  wysiwyg: require('./wysiwyg'),
  plain: require('./plain'),
  html: require('./plain'),
};

const DEFAULTS = {
  url: window.location.pathname,
  method: (window.location.pathname.split('/').length === 2 ? 'POST' : 'PUT'),
  autosave: true,
};

module.exports = () => {
  const { $el, selector } = el('.js-page-editor');

  if (!$el) return;

  return MODES[BOOTSTRAP.page && BOOTSTRAP.page.mode || 'wysiwyg']({
    $el: $el,
    selector: selector,
    STATE: STATE,
    DEFAULTS: DEFAULTS,
  });
};
