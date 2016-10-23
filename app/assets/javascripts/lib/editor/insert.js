module.exports = editor => {
  const __delete__ = range => {
    editor.setSelection(range.index, range.length, Quill.sources.SILENT);
    editor.deleteText(range.index, range.length, Quill.sources.SILENT);
  };

  return {
    notification: (range, message) => {
      __delete__(range);

      editor.insertText(range.index, message, Quill.sources.SILENT);
      editor.setSelection(range.index, message.length, Quill.sources.SILENT);

      return editor.getSelection(true);
    },

    image: (range, url) => {
      __delete__(range);

      editor.insertEmbed(range.index, 'image', url, Quill.sources.USER);
      editor.setSelection(range.index + 1, Quill.sources.SILENT);

      return editor.getSelection(true);
    },
  };
};
