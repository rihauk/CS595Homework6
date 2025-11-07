#!/bin/bash

npm init -y
npm install -D tsx typescript @types/node
npm install @aztec/bb.js

echo "Setup complete. To run, call: npx tsx demo.ts"