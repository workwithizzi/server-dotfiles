const fs = require("fs");
const path = require("path");

// PATH to the hooks/ directory
const dir = `${__dirname}`;
console.log(dir);

const data = [];

fs.readdir(dir, (err, files) => {
  return new Promise((resolve, reject) => {
    if (err) reject(err);
    files.forEach(file => {
      console.log(file);
      if (path.extname(file) === ".json" && file !== "combiner_hook.json") {
        const x = fs.readFileSync(file);
        data.push(x.toString("utf-8").slice(1, -2));
        console.log(data);
      }
    });
    resolve(data);
  }).then(data => {
    fs.writeFileSync("combiner_hook.json", "[" + data + "\n]");
  });
});