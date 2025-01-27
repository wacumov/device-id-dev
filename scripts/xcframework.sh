#!/usr/bin/env bash

xcodebuild -scheme $1 -destination generic/platform=iOS -archivePath ./archives/$1 SKIP_INSTALL=NO archive
xcodebuild -scheme $1 -destination generic/platform="iOS Simulator" -archivePath ./archives/$1-Simulator SKIP_INSTALL=NO archive

cp -r ./archives/$1.xcarchive/Products/Library/Frameworks/. ./archives/$1
cp -r ./archives/$1-Simulator.xcarchive/Products/Library/Frameworks/. ./archives/$1-Simulator

xcodebuild -create-xcframework -framework ./archives/$1/$1.framework  -framework ./archives/$1-Simulator/$1.framework -output ./$1.xcframework
rm -rf ./archives
