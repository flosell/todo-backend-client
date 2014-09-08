#!/bin/bash -e

REPO_DIR=/tmp/mockrepo

echo "Publishing to $REPO_DIR"

cp build/package.tar.gz $REPO_DIR/client-snapshot.tar.gz
cp deploy.sh $REPO_DIR/deploy-frontend.sh