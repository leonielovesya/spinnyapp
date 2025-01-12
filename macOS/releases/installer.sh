#!/bin/bash

#########################################################################################################
#                                    The bloxyspin installer @ macOS v0.0.1!                            #
#                                                                                                       #
#                                    This content belongs to app.bloxyspin.com                          #
#########################################################################################################

# Ensure macOS
[[ "$(uname)" != "Darwin" ]] && { echo "This script is for macOS only. Your OS: $(uname)"; exit 1; }

# Constants
ZIP_URL="https://objects.githubusercontent.com/github-production-release-asset-2e65be/915188585/30d5ccaa-fb4a-4a74-aeea-b599fbe33227?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=releaseassetproduction%2F20250112%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250112T160756Z&X-Amz-Expires=300&X-Amz-Signature=22227a1e5056d2661902eeffd061d57eb6bea9b63a47c8154ca802e954714fe4&X-Amz-SignedHeaders=host&response-content-disposition=attachment%3B%20filename%3Dbloxyspin.zip&response-content-type=application%2Foctet-stream"
APP_PATH="/Applications/bloxyspin.app"

# Download and extract directly into /Applications
echo "Installing BloxySpin..."
curl -L "$ZIP_URL" | bsdtar -xf - -C "/Applications"

# Configure permissions in one step
sudo xattr -d com.apple.quarantine "$APP_PATH" && sudo spctl --add --label "allow" "$APP_PATH"

# Launch the app
open "$APP_PATH"

echo "BloxySpin is ready to use. Good luck!"

