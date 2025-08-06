#!/bin/bash

# AUR Package Update Script for StrengthTracker
# This script helps update the AUR package with new versions

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}StrengthTracker AUR Package Update Script${NC}"
echo "=========================================="

# Check if version is provided
if [ -z "$1" ]; then
    echo -e "${RED}Error: Please provide a version number${NC}"
    echo "Usage: $0 <version>"
    echo "Example: $0 1.0.1"
    exit 1
fi

VERSION=$1
echo -e "${YELLOW}Updating to version: $VERSION${NC}"

# Build the package to get the source tarball
echo "Building Python package..."
python -m build

# Find the source tarball
TARBALL=$(find dist -name "strength_tracker-$VERSION.tar.gz" | head -n 1)

if [ -z "$TARBALL" ]; then
    echo -e "${RED}Error: Could not find source tarball for version $VERSION${NC}"
    exit 1
fi

echo "Found tarball: $TARBALL"

# Calculate SHA256
SHA256=$(sha256sum "$TARBALL" | cut -d' ' -f1)
echo "SHA256: $SHA256"

# Update PKGBUILD
echo "Updating PKGBUILD..."
sed -i "s/^pkgver=.*/pkgver=$VERSION/" PKGBUILD
sed -i "s/^sha256sums=.*/sha256sums=('$SHA256')/" PKGBUILD

# Update .SRCINFO
echo "Updating .SRCINFO..."
makepkg --printsrcinfo > .SRCINFO

echo -e "${GREEN}Successfully updated AUR package files!${NC}"
echo ""
echo "Next steps:"
echo "1. Review the changes: git diff"
echo "2. Commit the changes: git add PKGBUILD .SRCINFO"
echo "3. Push to AUR: git push origin main"
