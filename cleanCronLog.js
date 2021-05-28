const fs = require('fs/promises');
const path = require('path');

const { EOL } = require('os')

const pathToCronJobLog = path.resolve(
 path.dirname(path.dirname(path.dirname(__filename))),
  '.logs',
  'crontab.log'
);

(async () => {
  const logFileContent = await fs.readFile(pathToCronJobLog, { encoding: 'utf-8' });
  const trimmedFileContent = logFileContent.replace(/No(.*)/gmi, '').replace(/^\s*$(?:\r\n?|\n)/gm, '');
  await fs.writeFile(pathToCronJobLog, trimmedFileContent.trim().concat(EOL));
})();
