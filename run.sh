#!/bin/bash -x

if [ -z ${FIREBASE_PROJECT_ID+x} ];
then echo "FIREBASE_PROJECT_ID must be set";
exit 1;
fi;

npm install
node_modules/.bin/firebase deploy --project $FIREBASE_PROJECT_ID
curl -v https://$FIREBASE_PROJECT_ID.firebaseapp.com/hello --compressed 2>&1 | grep -i content-type
