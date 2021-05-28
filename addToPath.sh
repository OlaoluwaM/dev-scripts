#!/usr/bin/env bash

pathToCheckFor="$HOME/.local/bin"

echo $PATH | grep -q $pathToCheckFor

if [ $? -eq 1 ]; then
  echo "/.local/bin not found in PATH, adding..."
  export PATH=$PATH:/home/olaolu/.local/bin
  echo "/.local/bin added."
fi
