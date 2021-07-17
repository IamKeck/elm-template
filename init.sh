#!/bin/bash
set -Cue
if [ $# -eq 0 ]; then
    echo "arg required"
    exit 1;
fi
git clone https://github.com/IamKeck/elm-template $1
cd $1
rm -rf .git
npm install
expect -c "
spawn npx elm init
expect {would you like me to create an elm.json file now? \[Y/n\]: }
send \"y\n\"
interact
"
npm run build
if [ -e init.sh ]; then
    rm init.sh
fi
git init
git add .
git commit -m "initial commit"
