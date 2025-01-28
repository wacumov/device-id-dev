# DeviceID
This repository contains the source code for the DeviceID library.

### For Development
Open Package.swift in Xcode.

### To Build XCFramework
1. Install XcodeGen (used to generate the `.xcodeproj` file):
```bash
brew install xcodegen
```
2. Run:
```bash
make xcframework
```
This builds the XCFramework and generates its checksum for distribution.