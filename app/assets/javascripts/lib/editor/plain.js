const R = require('ramda');
const Autosave = require('./autosave');

module.exports = ({ $el, STATE, DEFAULTS }) => {
  const OPTIONS = R.merge(DEFAULTS, $el.data());

  const autosaver = new Autosave({
    STATE,
    OPTIONS,
    data: () => ({
      content: $el.val(),
    }),
  });

  if (OPTIONS.autosave) {
    $el.on('input', () => {
      STATE.is.edited = true;
      autosaver.notify('Pending');
      autosaver.debounced();
    });
  }
};
