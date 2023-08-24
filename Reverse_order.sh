#!/usr/bin/env bash

echo "Before reversing the order"

echo "---------------------------"

cat test_replace.txt

rev <<< test_replace.txt

echo "After reversing"

echo "----------------"

cat test_replace.txt