#!/usr/bin/env bash

read -p "Enter a word to replace with: " word

echo $word

sed -i "s/India/$word/g" test_replace.txt