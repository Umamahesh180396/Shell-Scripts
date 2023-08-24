#!/usr/bin/env bash

read -p "Enter a word to check: " INPUT

if [[ $(echo "$INPUT" | rev) == "$INPUT" ]]
then
    echo "Given word/Phrase is a palindrome"
else
    echo "Given word/Phrase is a not a palindrome"
fi