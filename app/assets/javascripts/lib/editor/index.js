const R = require('ramda');
const el = require('../el');
const save = require('./save');
const wait = require('../wait');

const CONFIG = require('./config');

const STATE = {
  is: {
    edited: false,
    saving: false,
  },
};

const DEFAULTS = {
  url: window.location.pathname,
  method: (window.location.pathname.split('/').length === 2 ? 'POST' : 'PUT'),
  autosave: true,
};

module.exports = () => {
  const { $el, selector } = el('.js-page-editor');

  if (!$el.length) return;

  const OPTIONS = R.merge(DEFAULTS, $el.data());

  const editor = new Quill(selector, CONFIG.authenticated[BOOTSTRAP.authenticated]);

  const $status = $('.js-page-status');

  if (BOOTSTRAP.editor && BOOTSTRAP.editor.delta) {
    editor.setContents(BOOTSTRAP.editor.delta);
  }

  editor.focus();

  if (OPTIONS.autosave) {
    editor.on('text-change', () => {
      STATE.is.edited = true;
      $status.text('Pending');
    });
  }

  // Ensure we don't leave before unsaved changes are persisted
  $(window).on('beforeunload', () => {
    if (STATE.is.edited) {
      return 'There are unsaved changes. Are you sure you want to leave?';
    }
  });

  const __save__ = () => {
    if ((OPTIONS.autosave && !STATE.is.edited) || STATE.is.saving) return;

    STATE.is.saving = true;
    $status.text('Saving');

    return save(editor, OPTIONS)
      .then(res => {
        STATE.is.saving = false;
        STATE.is.edited = false;

        wait(500)
          .then(() =>
            $status.text('Saved'));

        return res;
      });
  };

  // Save periodically
  if (OPTIONS.autosave) {
    setInterval(__save__, 2500);
  }

  // Set up keybindings
  editor.keyboard.addBinding({
    key: 's',
    shortKey: true,
    handler: () => {
      if (OPTIONS.create) {
        __save__()
          .then(({ url }) => {
            window.location = url;
          });
      }
      __save__();
    },
  });

  return editor;
};
