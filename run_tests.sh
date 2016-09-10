#!/bin/sh

./test.sh
fswatch -o test.sh test-app server | xargs -n1 ./test.sh