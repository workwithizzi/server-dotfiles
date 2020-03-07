const fs = require("fs");

const writeFile = (path, data, opts = "utf8") =>
  new Promise((resolve, reject) => {
    fs.writeFile(path, data, opts, (err) => {
      if (err) {
        reject(err);
      } else {
        resolve();
      }
    });
  });

module.exports = writeFile;
