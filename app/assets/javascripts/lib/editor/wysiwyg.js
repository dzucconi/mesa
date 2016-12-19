const R = require('ramda');
const Autosave = require('./autosave');
const CONFIG = require('./config');

module.exports = ({ $el, selector, STATE, DEFAULTS }) => {
  const OPTIONS = R.merge(DEFAULTS, $el.data());

  const editor = new Quill(selector, CONFIG.authenticated[BOOTSTRAP.authenticated]);

  if (BOOTSTRAP.page && BOOTSTRAP.page.delta) {
    editor.setContents(BOOTSTRAP.page.delta);
  }

  editor.focus();

  const autosaver = new Autosave({
    STATE,
    OPTIONS,
    data: () => ({
      html: editor.root.innerHTML,
      delta: JSON.stringify(editor.getContents()),
    }),
  });

  if (OPTIONS.autosave) {
    editor.on('text-change', () => {
      STATE.is.edited = true;
      autosaver.notify('Pending');
      autosaver.debounced();
    });
  }

  // Set up keybindings
  editor.keyboard.addBinding({
    key: 's',
    shortKey: true,
    handler: () => {
      if (OPTIONS.create) {
        autosaver.exec()
          .then(({ url }) => {
            window.location = url;
          });
      }
      autosaver.exec();
    },
  });

  return editor;
};
