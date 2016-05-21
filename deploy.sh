#!/bin/bash -e

if [ -z "${VERSION}" ]; then
  echo "ERROR: No VERSION defined!"
  exit 1
fi

if [ -z "${DEPLOY_ENVIRONMENT}" ]; then
  echo "ERROR: No DEPLOY_ENVIRONMENT defined!"
  exit 1
fi

if [ "${DEPLOY_ENVIRONMENT}" == "ci" ]; then
  PUBLIC_FACING_PORT=8082
  BACKEND_PORT=8081
elif [ "${DEPLOY_ENVIRONMENT}" == "qa" ]; then
  PUBLIC_FACING_PORT=8092
  BACKEND_PORT=8091
else
  echo "DEPLOY_ENVIRONMENT must be ci or qa"
fi

CONTAINER_NAME="lambdacd-demo_${DEPLOY_ENVIRONMENT}_frontend"

echo -e "\033[1mStopping old containers in ${DEPLOY_ENVIRONMENT}...\033[0m"
docker kill $CONTAINER_NAME >/dev/null 2>&1 || true
docker rm $CONTAINER_NAME >/dev/null 2>&1  || true

echo -e "\033[1mStarting Container in ${DEPLOY_ENVIRONMENT}...\033[0m"

docker run --name "${CONTAINER_NAME}" -p $PUBLIC_FACING_PORT:80 -d lambdacd-demo/frontend:${VERSION} >/dev/null

echo -e "\033[1mContainer now running on http://localhost:${PUBLIC_FACING_PORT}/?http://localhost:${BACKEND_PORT}/todos\033[0m"