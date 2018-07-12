#!/bin/sh

(cd /Users/knd/Code/chainz-configurator && ./gradlew clean build -Pinstance=local) || exit 1;

cd /Users/knd/Code/chainz-configurator/chainz-configurator-component/src/main/jetty/local;

java -jar /Users/knd/Downloads/jetty-distribution-9.4.11.v20180605/start.jar \
  -Dchainz.initData=true \
  -Dchainz.stripeApiKey=sk_test_Ml04HoLJNwKeIV11nQad7gA1 \
  -Dchainz.apikey.publicKeyPath=/Users/knd/.ssh/apikey-rsa.pub \
  -Dchainz.apikey.privateKeyPath=/Users/knd/.ssh/apikey-rsa \
  -Dchainz.cloudNamespace=local-khanh;
