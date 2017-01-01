const debounce = require('debounce-promise');
const wait = require('../wait');
const save = require('./save');

module.exports = class Autosave {
  constructor({ data, OPTIONS, STATE }) {
    this.data = data;
    this.OPTIONS = OPTIONS;
    this.STATE = STATE;
    this.$el = $('.js-page-status');

    this.debounced = debounce(() => this.exec(), 1000);

    this.bind();
  }

  bind() {
    $(window).on('beforeunload', () => {
      if (this.STATE.is.edited) {
        return `
          There are unsaved changes.
          Are you sure you want to leave?
        `;
      }
    });
  }

  exec() {
    if ((this.OPTIONS.autosave && !this.STATE.is.edited) || this.STATE.is.saving) return;

    this.STATE.is.saving = true;

    this.notify('Saving');

    return save(this.data(), this.OPTIONS)
      .then(res => {
        this.STATE.is.saving = false;
        this.STATE.is.edited = false;

        wait(500)
          .then(() =>
            this.notify('Saved'));

        return res;
      });
  }

  notify(message) {
    this.$el.text(message);
  }
};
