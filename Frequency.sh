#!/usr/bin/env bash

echo test | tr ' ' '/n' | sort | uniq -c | sort -n