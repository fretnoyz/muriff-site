#!/bin/bash

# Muriff Version Bump Script
# Usage: ./bump-version.sh [major|minor|patch|auto]

set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get current version from index.html
CURRENT_VERSION=$(grep -oP 'v\K[0-9]+\.[0-9]+\.[0-9]+' index.html | head -1)

if [ -z "$CURRENT_VERSION" ]; then
    echo "Error: Could not find version in index.html"
    exit 1
fi

IFS='.' read -r -a VERSION_PARTS <<< "$CURRENT_VERSION"
MAJOR="${VERSION_PARTS[0]}"
MINOR="${VERSION_PARTS[1]}"
PATCH="${VERSION_PARTS[2]}"

echo "Current version: v$CURRENT_VERSION"

# Determine bump type
BUMP_TYPE="${1:-auto}"

if [ "$BUMP_TYPE" = "auto" ]; then
    # Analyze git diff to suggest version bump
    DIFF=$(git diff HEAD~1..HEAD 2>/dev/null || echo "")

    # Check for breaking changes or major refactors
    if echo "$DIFF" | grep -qiE "(BREAKING|breaking change|major refactor)"; then
        BUMP_TYPE="major"
        echo -e "${YELLOW}Auto-detected: MAJOR bump (breaking changes detected)${NC}"
    # Check for new features
    elif echo "$DIFF" | grep -qiE "(feat|feature|new|add .* function|add .* component)"; then
        BUMP_TYPE="minor"
        echo -e "${YELLOW}Auto-detected: MINOR bump (new features detected)${NC}"
    # Default to patch for bug fixes and small changes
    else
        BUMP_TYPE="patch"
        echo -e "${YELLOW}Auto-detected: PATCH bump (minor changes/fixes)${NC}"
    fi
fi

# Calculate new version
case "$BUMP_TYPE" in
    major)
        MAJOR=$((MAJOR + 1))
        MINOR=0
        PATCH=0
        ;;
    minor)
        MINOR=$((MINOR + 1))
        PATCH=0
        ;;
    patch)
        PATCH=$((PATCH + 1))
        ;;
    *)
        echo "Error: Invalid bump type. Use: major, minor, patch, or auto"
        exit 1
        ;;
esac

NEW_VERSION="$MAJOR.$MINOR.$PATCH"
echo -e "${GREEN}New version: v$NEW_VERSION${NC}"

# Update version in both HTML files
sed -i "s/v$CURRENT_VERSION/v$NEW_VERSION/g" index.html
sed -i "s/v$CURRENT_VERSION/v$NEW_VERSION/g" wwsd.html

echo -e "${GREEN}✓ Updated index.html${NC}"
echo -e "${GREEN}✓ Updated wwsd.html${NC}"
echo ""
echo "Don't forget to commit these changes!"
