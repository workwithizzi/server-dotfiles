const fs = require("fs");

const readDir = dir =>
  new Promise((resolve, reject) => {
    fs.readdir(dir, (err, files) => {
      if (err) {
        reject(err);
      } else {
        resolve(files);
      }
    });
  });

module.exports = readDir;
