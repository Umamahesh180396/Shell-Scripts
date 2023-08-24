#!/usr/bin/env bash

rm -f replaced.txt

echo "Before reversing the order"

echo "---------------------------"

cat test_replace.txt

rev test_replace.txt &>> replaced.txt 

echo "After reversing"

echo "----------------"

cat replaced.txt