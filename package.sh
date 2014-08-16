#!/bin/bash -e

mkdir -p build
rm -rf build/*

tar czf build/package.tar.gz index.html js/ css/ bower_components