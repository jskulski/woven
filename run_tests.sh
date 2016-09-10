#!/bin/sh

fswatch -o test.sh test-app | xargs -n1 ./test.sh