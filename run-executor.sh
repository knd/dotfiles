#!/bin/sh

export JBOSS_BASE_DIR="/Users/knd/Code/chainz-executor/chainz-executor-component/src/main/wildfly/local/";

(cd /Users/knd/Code/chainz-executor && ./gradlew clean build -Pinstance=local) || exit 1;

cd /Users/knd/Code/wildfly-11.0.0.Final/bin;

./standalone.sh --debug --server-config=standalone-full.xml \
  -Dchainz.azure.credentialsFile=/Users/knd/Code/chainz-executor/chainz-executor-component/credentials \
  -Dchainz.bashFolder=/Users/knd/Code/chainz-executor/chainz-executor-component/src/main/bash \
  -Dchainz.cloud.privateKeyPath=/Users/knd/.ssh/cloud-ssh-key \
  -Dchainz.cloud.publicKeyPath=/Users/knd/.ssh/cloud-ssh-key.pub \
  -Dchainz.cloudNamespace=local-knd \
  -Dchainz.apikey.publicKeyPath=/Users/knd/.ssh/apikey-rsa;
