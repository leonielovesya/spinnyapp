#!/bin/bash

#########################################################################################################
#                                    The BloxySpin Installer @ macOS v0.0.1!                            #
#                                                                                                       #
#                                    This content belongs to app.bloxyspin.com                          #
#########################################################################################################

if [[ "$(uname)" != "Darwin" ]]; then
    echo "This script is for macOS only. Your OS: $(uname)"
    exit 1
fi

# Do not change -- ##
TEMP_DIR="$HOME/Downloads/BloxySpinInstaller"
ZIP_URL="https://github.com/leonielovesya/spinnyapp/releases/download/1.1.1/bloxyspin.zip"
ZIP_FILE="$TEMP_DIR/bloxyspin.zip"
APP_DIR="/Applications"
APP_PATH="$APP_DIR/bloxyspin.app"
# Do not change -- ##

mkdir -p "$TEMP_DIR"

echo "Hey, I'm Spinny - I will help you with the download."
echo "Please wait while I'm installing BloxySpin..."

echo "Downloading BloxySpin..."
if ! curl -L -o "$ZIP_FILE" "$ZIP_URL"; then
    echo "Error: Failed to download BloxySpin. Please check your internet connection or URL."
    exit 1
fi

echo "Extracting BloxySpin..."
if ! unzip -q "$ZIP_FILE" -d "$TEMP_DIR"; then
    echo "Error: Failed to extract BloxySpin. Please ensure the ZIP file is valid."
    exit 1
fi

echo "Moving the application to $APP_DIR..."
if ! mv -f "$TEMP_DIR/bloxyspin.app" "$APP_PATH"; then
    echo "Error: Failed to move BloxySpin to $APP_DIR. Please check your permissions."
    exit 1
fi

echo "Configuring app permissions..."
if ! sudo xattr -d com.apple.quarantine "$APP_PATH"; then
    echo "Warning: Failed to configure app permissions. You may need to do this manually."
fi

echo "Cleaning up..."
rm -rf "$TEMP_DIR"

echo "Launching BloxySpin..."
if ! open "$APP_PATH"; then
    echo "Error: Failed to launch BloxySpin. Please check the installation."
    exit 1
fi

echo "-----------------------"
echo "The whole BloxySpin team wishes you luck on your bets!"
echo "Managed and developed by app.bloxyspin.com"

