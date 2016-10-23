const engine = {
  url: `${window.location.pathname}/uploads`,

  /**
   * @returns {Promise} resolves with a File (augmented with `url`)
   */
  upload: (__file__, progress) =>
    engine
      // New Upload on the server
      .create(__file__)

      // Store the file on S3
      .then(([file, url]) =>
        engine.store(file, url, progress)),

  /**
   * Creates an Upload object on the server
   * @param {File}
   * @returns {Promise} resolves with an Array containing a File with augmented `url` property and a PUT url
   */
  create: file =>
    new Promise((resolve, reject) =>
      $.ajax({
        url: engine.url,
        method: 'POST',
        data: { upload: {
          file_name: file.name,
          file_size: file.size,
          content_type: file.type
        }},
        error: reject,
        success: response => {
          file.url = response.get;
          resolve([file, response.put]);
        },
      })
    ),

  /**
   * Takes a File, an authenticated PUT url, and a progress fn and uploads via the PUT
   * @params {File, String, Function}
   * @returns {Promise}
   */
  store: (file, url, progress) =>
    new Promise((resolve, reject) =>
      $.ajax({
        url: url,
        data: file,
        type: 'PUT',
        processData: false,
        contentType: false,
        error: reject,
        xhr: () => {
          const xhr = new window.XMLHttpRequest;
          xhr.upload.addEventListener('progress', e => {
            if (e.lengthComputable) {
              const percentage = e.loaded / e.total;
              progress(percentage);
            }
          }, false);
          return xhr;
        },
        success: () =>
          resolve(file),
      })
    ),

  /**
   * Augments the File object with `width` and `height` properties
   * @params {File}
   * Returns {Promise} resolves File
   */
  dimensions: file => {
    return new Promise(resolve => {
      try {
        const reader = new FileReader;
        reader.onload = (e) => {
          var image = new Image;
          image.onload = function() {
            file.width = this.width;
            file.height = this.height;
            resolve(file);
          };
          image.src = e.target.result;
        };
        reader.readAsDataURL(file);
      } catch(e) {
        file.width = 0;
        file.height = 0;
        resolve(file);
      }
    });
  },
};

module.exports = engine;
