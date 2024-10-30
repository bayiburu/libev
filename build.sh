#!/bin/bash

PROJECT="libev.xcodeproj"
SCHEME="libev"

rm -rf build

xcodebuild clean

# Build for iOS device
xcodebuild archive \
	-project "$PROJECT" \
	-scheme "$SCHEME" \
	-destination 'generic/platform=iOS' \
	-archivePath "build/iphoneos.xcarchive" \
	SKIP_INSTALL=NO \
	BUILD_LIBRARY_FOR_DISTRIBUTION=YES


# Build for iOS simulator
xcodebuild archive \
	-project "$PROJECT" \
	-scheme "$SCHEME" \
	-destination 'generic/platform=iOS Simulator' \
	-archivePath "build/iphonesimulator.xcarchive" \
	SKIP_INSTALL=NO \
	BUILD_LIBRARY_FOR_DISTRIBUTION=YES

# Build for macOS
xcodebuild archive \
	-project "$PROJECT" \
	-scheme "$SCHEME" \
	-destination 'generic/platform=macOS' \
	-archivePath "build/macos.xcarchive" \
	SKIP_INSTALL=NO \
	BUILD_LIBRARY_FOR_DISTRIBUTION=YES

# Create the XCFramework
xcodebuild -create-xcframework \
	-framework "build/iphoneos.xcarchive/Products/Library/Frameworks/$SCHEME.framework" \
	-framework "build/iphonesimulator.xcarchive/Products/Library/Frameworks/$SCHEME.framework" \
	-framework "build/macos.xcarchive/Products/Library/Frameworks/$SCHEME.framework" \
	-output "build/Clibev.xcframework"
