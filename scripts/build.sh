#!/bin/bash

# Flutter Boilerplate Build Script
# Usage: ./scripts/build.sh [platform] [flavor] [options]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default values
PLATFORM=${1:-all}
FLAVOR=${2:-production}
CLEAN=${3:-false}
TEST=${4:-true}

echo -e "${BLUE}🚀 Flutter Boilerplate Build Script${NC}"
echo -e "${BLUE}Platform: $PLATFORM${NC}"
echo -e "${BLUE}Flavor: $FLAVOR${NC}"
echo -e "${BLUE}Clean: $CLEAN${NC}"
echo -e "${BLUE}Test: $TEST${NC}"

# Function to print status
print_status() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    print_error "Flutter is not installed or not in PATH"
    exit 1
fi

# Clean if requested
if [ "$CLEAN" = "true" ]; then
    echo -e "${YELLOW}🧹 Cleaning project...${NC}"
    flutter clean
fi

# Get dependencies
echo -e "${BLUE}📦 Getting dependencies...${NC}"
flutter pub get

# Generate code
echo -e "${BLUE}🔨 Generating code...${NC}"
flutter pub run build_runner build --delete-conflicting-outputs

# Run tests if requested
if [ "$TEST" = "true" ]; then
    echo -e "${BLUE}🧪 Running tests...${NC}"
    flutter test --coverage

    if [ $? -eq 0 ]; then
        print_status "All tests passed"
    else
        print_error "Some tests failed"
        exit 1
    fi
fi

# Analyze code
echo -e "${BLUE}🔍 Analyzing code...${NC}"
flutter analyze

if [ $? -eq 0 ]; then
    print_status "Code analysis passed"
else
    print_warning "Code analysis found issues"
fi

# Build based on platform
case $PLATFORM in
    "android"|"apk")
        echo -e "${BLUE}🤖 Building Android APK...${NC}"
        flutter build apk --release --flavor $FLAVOR -t lib/main.dart

        if [ $? -eq 0 ]; then
            print_status "Android APK built successfully"
            echo -e "${GREEN}📱 APK location: build/app/outputs/apk/$FLAVOR/release/${NC}"
        else
            print_error "Android build failed"
            exit 1
        fi
        ;;

    "ios")
        echo -e "${BLUE}🍎 Building iOS...${NC}"
        flutter build ios --release --flavor $FLAVOR -t lib/main.dart

        if [ $? -eq 0 ]; then
            print_status "iOS build completed successfully"
            echo -e "${GREEN}📱 iOS location: build/ios/iphoneos/${NC}"
        else
            print_error "iOS build failed"
            exit 1
        fi
        ;;

    "web")
        echo -e "${BLUE}🌐 Building Web...${NC}"
        flutter build web --release --flavor $FLAVOR -t lib/main.dart

        if [ $? -eq 0 ]; then
            print_status "Web build completed successfully"
            echo -e "${GREEN}🌐 Web location: build/web/${NC}"
        else
            print_error "Web build failed"
            exit 1
        fi
        ;;

    "all")
        echo -e "${BLUE}🔄 Building all platforms...${NC}"

        # Build Android
        echo -e "${YELLOW}🤖 Building Android...${NC}"
        flutter build apk --release --flavor $FLAVOR -t lib/main.dart

        # Build iOS
        echo -e "${YELLOW}🍎 Building iOS...${NC}"
        flutter build ios --release --flavor $FLAVOR -t lib/main.dart

        # Build Web
        echo -e "${YELLOW}🌐 Building Web...${NC}"
        flutter build web --release --flavor $FLAVOR -t lib/main.dart

        print_status "All platforms built successfully"
        echo -e "${GREEN}📱 Android: build/app/outputs/apk/$FLAVOR/release/${NC}"
        echo -e "${GREEN}📱 iOS: build/ios/iphoneos/${NC}"
        echo -e "${GREEN}🌐 Web: build/web/${NC}"
        ;;

    *)
        print_error "Unknown platform: $PLATFORM"
        echo "Supported platforms: android, ios, web, all"
        exit 1
        ;;
esac

echo -e "${GREEN}🎉 Build completed successfully!${NC}"
