#!/bin/zsh

git clone https://github.com/htuch/text-aid-too.git ~/.text-aid-too

cd ~/.text-aid-too/server
npm install watchr optimist ws markdown html
