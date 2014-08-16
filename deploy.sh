#!/bin/bash -e

if [ $# -lt 2 ]; then
  echo "usage: <environment> <tarfile>"
  exit 1
fi

ENVIRONMENT=$1
TARFILE=$2

echo "Deploying $TARFILE to $ENVIRONMENT..."

ssh vagrant@$ENVIRONMENT "cd /var/www && rm -rf *"
scp $TARFILE vagrant@$ENVIRONMENT:/var/www/deployed.tar.gz
ssh vagrant@$ENVIRONMENT "cd /var/www && tar xfz deployed.tar.gz"

RETRIES=5

for i in $(seq $RETRIES); do
  if curl localhost:20080/index.html --silent --fail; then 
    echo "Found deployed version"
    exit 0
  else 
    echo "waiting for deployed version..."
    sleep 1
  fi
done

echo "ERROR, no deployed version found after $RETRIES retries"
exit 1