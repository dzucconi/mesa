module.exports = {
  authenticated: {
    false: {
      readOnly: true,
      theme: 'bubble',
      modules: {
        toolbar: false,
      }
    },

    true: {
      theme: 'bubble',
      modules: {
        toolbar: [
          ['bold', 'italic', 'underline', 'strike'],
          ['blockquote', 'code-block'],
          ['link'],
          [{ 'header': 1 }, { 'header': 2 }],
          [{ 'list': 'bullet' }],
          [{ 'align': [] }],
          ['clean'],
        ],
      },
    }
  }
};
