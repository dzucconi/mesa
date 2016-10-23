module.exports = (editor, { url, method }) => {
  return $.ajax({
    method: method,
    url: url,
    data: {
      page: {
        html: editor.root.innerHTML,
        delta: JSON.stringify(editor.getContents()),
      },
    },
  });
};
