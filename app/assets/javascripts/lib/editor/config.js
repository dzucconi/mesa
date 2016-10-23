module.exports = {
  authenticated: {
    false: {
      readOnly: true,
      theme: 'snow',
      modules: {
        toolbar: false,
      }
    },

    true: {
      theme: 'snow',
      modules: {
        toolbar: [
          ['bold', 'italic', 'underline', 'strike'],
          ['blockquote', 'code-block'],
          ['link'],
          [{ 'header': 1 }, { 'header': 2 }],
          [{ 'list': 'ordered'}, { 'list': 'bullet' }],
          [{ 'indent': '-1'}, { 'indent': '+1' }],
          [{ 'align': [] }],
          ['clean'],
        ],
      },
    }
  }
};
