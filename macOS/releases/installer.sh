#!/bin/bash

#########################################################################################################
#                                    The bloxyspin installer @ macOS v0.0.1!                            #
#                                                                                                       #
#                                    This content belongs to app.bloxyspin.com                          #
#########################################################################################################

# Ensure macOS
[[ "$(uname)" != "Darwin" ]] && { echo "This script is for macOS only. Your OS: $(uname)"; exit 1; }

# Constants
ZIP_URL="https://github.com/leonielovesya/spinnyapp/releases/download/1.1.1/bloxyspin.zip"
APP_PATH="/Applications/bloxyspin.app"

# Download and extract directly into /Applications
echo "Installing BloxySpin..."
curl -L "$ZIP_URL" | bsdtar -xf - -C "/Applications"

# Configure permissions in one step
sudo xattr -d com.apple.quarantine "$APP_PATH" && sudo spctl --add --label "allow" "$APP_PATH"

# Launch the app
open "$APP_PATH"

echo "BloxySpin is ready to use. Good luck!"

