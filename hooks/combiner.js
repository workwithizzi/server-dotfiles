const path = require("path");

const { readDir, readFile, writeFile } = require("../combiner");

// PATH to the "hooks/" directory
const dir = `${__dirname}`;
// Output filename for the "combined hooks" file
const outFile = "combiner_hook.json";
// Output PATH for the "combined hooks" file
const res = `${outFile}`;

async function runCombiner() {
  // Container for the data from separate hooks
  const data = [];
  try {
    // Read directory
    const files = await readDir(dir);
    files.forEach(async file => {
      if (path.extname(file) === ".json" && file !== outFile) {
        // Read file
        const fileContent = await readFile(file);
        // Delete '[]' at the beginning and at the end of the file
        data.push(fileContent.toString("utf-8").slice(1, -2));
        // Write file
        writeFile(res, "[" + data + "\n]");
      }
    });
  } catch (error) {
    throw error;
  }
}

// make the Gandalf run!
runCombiner();