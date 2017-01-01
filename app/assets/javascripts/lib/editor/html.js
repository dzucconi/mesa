const Autosave = require('./autosave');

module.exports = ({ $el, STATE, DEFAULTS }) => {
  const OPTIONS = DEFAULTS;

  const $input = $el.find('.js-page-editor__input');
  const $preview = $el.find('.js-page-editor__preview');

  const autosaver = new Autosave({
    STATE,
    OPTIONS,
    data: () => ({
      html: $input.val(),
    }),
  });

  if (OPTIONS.autosave) {
    $input.on('input', () => {
      STATE.is.edited = true;
      autosaver.notify('Pending');
      autosaver.debounced()
        .then(() => $preview[0].contentWindow.location.reload());
    });
  }
};
