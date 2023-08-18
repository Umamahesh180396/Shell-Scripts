#!/usr/bin/env bash

cat test.txt | tr ' ' '\n' | sort | uniq -c | sort -n