const path = require("path");

const readDir = require("./readDir");
const readFile = require("./readFile");
const writeFile = require("./writeFile")
const testJSON = require("./testJSON");

// PATH to the "hooks/" directory
const dir = path.join(__dirname, '..', 'hooks');
// Output filename for the "combined hooks" file
const outFile = "combiner_hook.json";
// Output PATH for the "combined hooks" file
const res = `${dir}/${outFile}`;

async function runCombiner() {
  // Container for the data from separate hooks
  const data = [];
  try {
    // Read directory
    const files = await readDir(dir);
    for (const file of files) {
      if (path.extname(file) === ".json" && file !== outFile) {
        // Read file
        const fileContent = await readFile(`${dir}/${file}`);
        // Delete '[]' at the beginning and at the end of the file and push to the array
        data.push(fileContent.toString("utf-8").slice(1, -2));
      }
    }
    // Write file
    writeFile(res, "[" + data + "\n]");
    // Check if the Output file is valid
    // Read the output file
    const jsonContent = await readFile(res);
    // Check the JSON correctness
    testJSON(jsonContent);
  } catch (error) {
    throw error;
  }
}

// make the Gandalf run!
runCombiner();
