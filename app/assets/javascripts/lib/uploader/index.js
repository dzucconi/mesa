const R = require('ramda');
const el = require('../el');
const engine = require('./engine');
const resize = require('../resize');

// Uploads any files dropped onto the editor
// and inserts them at the cursor
module.exports = editor => {
  const { $el } = el('.js-page-editor');

  if (!$el.length) return;

  const insert = require('../editor/insert')(editor);

  $el
    .on('dragover', false)
    .on('drop', e => {
      e.preventDefault();

      const files = e.originalEvent.dataTransfer.files;

      // Will need to be per image and specific to images
      const max = parseInt(window.prompt('Specify the largest side in px', 900));

      let range = insert.notification(editor.getSelection(true), 'Uploading...');

      // Todo: Support multiple files
      R.map(file => {
        engine
          .upload(file, percentage => {
            range = insert.notification(range, `${Math.round(percentage * 100)}%`);
          })
          .then(file => {
            insert.image(range, resize({
              url: file.url,
              width: max,
              height: max,
            }));
          });
      }, files);
    });
};
