xcframework:
	xcodegen
	chmod +x ./scripts/xcframework.sh
	./scripts/xcframework.sh DeviceID
	zip DeviceID.xcframework.zip DeviceID.xcframework -r
	swift package compute-checksum DeviceID.xcframework.zip
