const path = require("path");

const readDir = require("./readDir");
const readFile = require("./readFile");
const writeFile = require("./writeFile")
const testJSON = require("./testJSON");

// Get the variables from arguments
// PATH to the "hooks/" directory
const inputDir = process.argv[2];
// Output PATH/file for the "combined hooks" file
const output = process.argv[3]


if (!inputDir || !output) {
	console.log(`You're command is missing required arguments`)
	return
}


async function runCombiner() {
  // Container for the data from separate hooks
  const data = [];
  try {
    // Read directory
    const files = await readDir(inputDir);
    for (const file of files) {
      if (path.extname(file) === ".json") {
        // Read file
        const fileContent = await readFile(`${inputDir}/${file}`);
        // Delete '[]' at the beginning and at the end of the file and push to the array
        data.push(fileContent.toString("utf-8").slice(1, -2));
      }
    }
    // Write file
    writeFile(output, "[" + data + "\n]");
    // Check if the Output file is valid
    // Read the output file
    const jsonContent = await readFile(output);
    // Check the JSON correctness
    testJSON(jsonContent);
  } catch (error) {
    throw error;
  }
}

// make the Gandalf run!
runCombiner();
