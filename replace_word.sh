#!/usr/bin/env bash

read -p "Enter a word to replace with: " WORD

sed -i "s/India/$WORD/g" test_replace.txt