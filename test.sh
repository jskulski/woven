#!/bin/sh
# Move to run_tests.sh
echo 'Test run:'
echo '------ - -  -- -- - - -----'

# Config
TEST_BUILD_DIR='TEST-BUILD-DIR'
TEST_APP_DIR='test-app'

SERVER_SRC_DIR='server'
SERVER_DOCKER_IMAGE_TAG_NAME='acceptance-test-woven-server'

# Setup
mkdir -p $TEST_BUILD_DIR

# Init
git init $TEST_BUILD_DIR

# Setup Test App
cp -r $TEST_APP_DIR $TEST_BUILD_DIR
(cd $TEST_BUILD_DIR && git add . && git commit -m "Adding app")

# Setup Woven server
docker build --no-cache $SERVER_SRC_DIR -t $SERVER_DOCKER_IMAGE_TAG_NAME
docker rmi $SERVER_DOCKER_IMAGE_TAG_NAME

# Cleanup
rm -rf $TEST_BUILD_DIR

echo '------ - -  -- -- - - -----'