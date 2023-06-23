#!/bin/bash

PROJECT_DIR=$PWD/..
DEV_KEY_DIR=$HOME/projects/garmin-dev-key
GARMIN_HOME=$HOME/Library/Application\ Support/Garmin/ConnectIQ/Sdks/connectiq-sdk-mac-4.1.7-2022-11-21-562b8a195/bin

echo "building..."
java -Xms1g -Dfile.encoding=UTF-8 -Dapple.awt.UIElement=true \
    -jar "$GARMIN_HOME/monkeybrains.jar" \
    -o "$PROJECT_DIR/dist/allthesmallthings.prg" \
    -f "$PROJECT_DIR/monkey.jungle" \
    -y "$DEV_KEY_DIR/developer_key" \
    -d fenix6xpro \
    -w \
    --unit-test
RESULT=$?
if [ $RESULT -ne 0 ]; then
    echo "BUILD FAILED";
    exit;
fi

echo "launching connectiq..."
"$GARMIN_HOME/connectiq"

echo "running tests..."
"$GARMIN_HOME/monkeydo" \
    "$PROJECT_DIR/dist/AllTheSmallThings.prg" \
    fenix6xpro \
    -t 

echo "killing simulator..."
SIMULATOR_PID=`ps -ef | grep Garmin | grep simulator | awk '{ print $2 }'`
kill $SIMULATOR_PID