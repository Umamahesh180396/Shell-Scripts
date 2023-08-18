#!/usr/bin/env bash

cat test | tr ' ' '/n' | sort | uniq -c | sort -n