module.exports = (data, { url, method }) => {
  return $.ajax({
    method: method,
    url: url,
    data: {
      page: data,
    },
  });
};
