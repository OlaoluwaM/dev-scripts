const fs = require('fs/promises');
const path = require('path');

function convertToSnakeCase(pathString) {
  const intermimPathString = pathString.replaceAll(/([A-Z]){2,}/g, match => `_${match}`);
  return intermimPathString
    .replaceAll(/([A-Z]){1}[a-z]{1,}/g, match => `_${match.toLocaleLowerCase()}`)
    .replaceAll('-', '_');
}

async function main() {
  const devFolderPath = path.resolve(path.dirname(path.dirname(__filename)), 'dev');
  const devDirs = await fs.readdir(devFolderPath);
  const foldersToSkip = ['optIn_scripts', 'optIn_custom_scripts'];

  for await (let dirName of devDirs) {
    if (foldersToSkip.includes(dirName)) continue;
    const oldPath = path.join(devFolderPath, dirName);
    const newPath = path.join(devFolderPath, convertToSnakeCase(dirName));
    await fs.rename(oldPath, newPath);
  }

  console.log('Rename Complete');
}

main();
