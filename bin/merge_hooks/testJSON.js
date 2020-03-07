function testJSON(json) {
  if (typeof json !== "string") {
    return false;
  }
  try {
    JSON.parse(json);
    console.log("Output file is a valid JSON.\nFile written successfully!");
    return true;
  }
  catch (error) {
    console.log("Output file is not a valid JSON.\nRun the script again!")
    return false;
  }
}

module.exports = testJSON;
