#!/bin/bash

# ++++++++++++++++++++++++++
# install pprof profiler shell
# Author : Shehan Avishka
# Date   : 21st June 2025
# ++++++++++++++++++++++++++

installedDate=$(date "+%Y-%m-%d, %H:%M:%S")

if ! [ -d "$HOME/.local/bin/" ]; then
  echo "creating... $HOME/.local/bin/"
  mkdir "$HOME/.local/bin/"
fi

currentPath=$(pwd)

toolShell="$currentPath/pprof-fetch.sh"

chmod 700 "$toolShell"

cp "$toolShell" "$HOME/.local/bin/"

if ! grep -q 'alias pprof-fetch=' ~/.bashrc; then
  echo "" >> ~/.bashrc
  echo "# pprof-fetch shell tool setup  $installedDate" >> ~/.bashrc
  echo "alias pprof-fetch='$HOME/.local/bin/pprof-fetch.sh'" >> ~/.bashrc
fi

echo "pprof-fetch <ip_address>"
echo "pprof-fetch 8.8.8.8"
echo "setting up completed..you can kill the terminal and start new session."