#!/bin/sh
# Move to run_tests.sh
echo 'Test run:'
echo '------ - -  -- -- - - -----'

# Config
TEST_BUILD_DIR='TEST-BUILD-DIR'
TEST_APP_DIR='test-app'


# Setup
mkdir -p $TEST_BUILD_DIR

# Init
git init $TEST_BUILD_DIR

# Copy app into directory
cp -r $TEST_APP_DIR $TEST_BUILD_DIR
(cd $TEST_BUILD_DIR && git add . && git commit -m "Adding app")

# Cleanup
rm -rf $TEST_BUILD_DIR

echo '------ - -  -- -- - - -----'