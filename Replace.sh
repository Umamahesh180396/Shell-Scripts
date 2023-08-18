#!/usr/bin/env bash

read -p "Enter a word to replace with: " word

replace=$word

sed -i "s|India|$replace|g" test_replace.txt