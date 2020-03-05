const fs = require("fs");
const path = require("path");

// PATH to the "hooks/" directory
const dir = `${__dirname}`;
// Output filename for the "combined hooks" file
const outFile = "combiner_hook.json";
// Output PATH for the "combined hooks" file
const res = `${outFile}`;

// Temporary container for the data from separate hooks
const data = [];

// Read directory
fs.readdir(dir, (err, files) => {
  if (err) throw (err);
  files.forEach(file => {
    if (path.extname(file) === ".json" && file !== outFile) {
      // Read file
      fs.readFile(file, (err, fileContent) => {
        if (err) throw err;
        // Write file
        data.push(fileContent.toString("utf-8").slice(1, -2));
        fs.writeFile(res, "[" + data + "\n]", err => {
          if (err) throw err;
        });
      });
    }
  });
});