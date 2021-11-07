#!/usr/bin/env bash

pathToCheckFor="$HOME/.local/bin"
[[ $1 = "-s"  ]] || [[ $1 = "--silent" ]] && shouldBeSilent=true || shouldBeSilent=false

echo $PATH | grep -q $pathToCheckFor

if [ $? -eq 1 ]; then
  [[ "$shouldBeSilent" = false ]] && echo "/.local/bin not found in PATH, adding..."
  export PATH=$PATH:/home/olaolu/.local/bin
  [[ "$shouldBeSilent" = false ]] && echo "/.local/bin added."
fi
