#!/bin/bash -e

if [ -z "${FRONTEND_VERSION}" ]; then
  echo "ERROR: No FRONTEND_VERSION defined!"
  exit 1
fi

echo -e "\033[1mLoading JS dependencies...\033[0m"
docker run -it --rm -v $(pwd):/data digitallyseamless/nodejs-bower-grunt:0.10 bower install

echo -e "\033[1mBuilding docker container...\033[0m"
docker build -t lambdacd-demo/frontend:${FRONTEND_VERSION} .