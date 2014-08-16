#!/bin/bash -e

mkdir -p build
rm -rf build/*

OUTPUTFILE=build/package.tar.gz

tar czf $OUTPUTFILE index.html js/ css/ bower_components

echo "Created $OUTPUTFILE"