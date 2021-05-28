#!/usr/bin/env node

# You can use fs.statSync to get the statistics of each file
# Specifically the mtimeMs. With that property use new Date to get the timestamp into a useable format
# Check how long its been since the file was modified
# If it has been modified within the past 10 days then sync; otherwise, do not sync
# Find a way to run this periodically and push the synced files to github

const { pipeline } = require('stream');
const { promisify } = require('util')
const { readdirSync, createReadStream, createWriteStream } = require('fs');

const pipe = promisify(pipeline);


const HOME = '/home/olaolu/';
const DOTFILE_PATH = `${HOME}olaolu_dev/.dotfiles/`;
const FILES = [".zshrc", ".bashrc", ".bash_aliases", "powerline-test.sh", ".npmrc", ".tmux.conf", ".profile", ".bash_profile", ".eslintrc.js"];
const notFound = [];

const PATHS = readdirSync(HOME).map(file => !FILES.includes(file) ? null : `${HOME}${file}`).filter(Boolean)

if (FILES.length > PATHS.length) {
   FILES.forEach(file => !PATHS.includes(`${HOME}${file}`) && console.log(`${file} not found`))
   console.log('Continuing with sync');
}

async function copySource() {
   console.log('Commencing sync...');

   for await (const path of PATHS) {
     const source = createReadStream(path);
     const output = createWriteStream(`${DOTFILE_PATH}linux/${path.replace(HOME, '')}`);
     await pipe(source, output);     
   }

   console.log('Sync Complete')
}

copySource();

