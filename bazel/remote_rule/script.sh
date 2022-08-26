#!/bin/bash
set -euo pipefail

NODE_BIN=$1
OUTPUT_PATH=$2

$NODE_BIN -e "console.log('Running node...')"
touch "$OUTPUT_PATH"
