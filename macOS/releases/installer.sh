#########################################################################################################
#                                    The BloxySpin Installer @ macOS v0.0.1!                           #
#                                                                                                       #
#                                    This content belongs to app.bloxyspin.com                         #
#########################################################################################################

if [[ "$(uname)" != "Darwin" ]]; then
    echo "This script is for macOS only. Your OS: $(uname)"
    exit 1
fi

# Variables
TEMP_DIR="$HOME/Downloads/BloxySpinInstaller"
ZIP_URL="https://github.com/leonielovesya/spinnyapp/releases/download/1.1.1/bloxyspin.zip"
ZIP_FILE="$TEMP_DIR/bloxyspin.zip"
APP_DIR="/Applications"
APP_PATH="$APP_DIR/bloxyspin.app"

# Prepare temp directory
mkdir -p "$TEMP_DIR"

echo "Hey, I'm Spinny - I will help you with the download."
echo "Please wait while I'm installing BloxySpin..."

# Download BloxySpin
echo "Downloading BloxySpin..."
if ! curl -L -o "$ZIP_FILE" "$ZIP_URL"; then
    echo "Failed to download BloxySpin. Please check the URL or your internet connection."
    exit 1
fi

# Remove any previous __MACOSX or conflicting files before extraction
echo "Cleaning up any conflicting files..."
rm -rf "$TEMP_DIR/__MACOSX" "$TEMP_DIR/bloxyspin.app"

# Extract BloxySpin
echo "Extracting BloxySpin..."
if ! unzip -q "$ZIP_FILE" -d "$TEMP_DIR"; then
    echo "Failed to extract BloxySpin. Please check the ZIP file."
    exit 1
fi

# Remove unwanted extended attributes (._ files) after extraction
echo "Cleaning up macOS-specific extended attributes..."
find "$TEMP_DIR" -name '._*' -exec rm -f {} \;

# Move app to Applications directory, requesting admin permissions if necessary
echo "Installing BloxySpin..."
if ! mv -f "$TEMP_DIR/bloxyspin.app" "$APP_PATH"; then
    echo "Moving the app requires administrative permissions."
    if ! sudo mv -f "$TEMP_DIR/bloxyspin.app" "$APP_PATH"; then
        echo "Failed to move the app to $APP_DIR even with administrative permissions."
        exit 1
    fi
fi

# Configure app permissions
echo "Configuring app permissions..."
if ! sudo xattr -d com.apple.quarantine "$APP_PATH" || ! sudo spctl --add --label "allow" "$APP_PATH"; then
    echo "Failed to configure app permissions. Please try again."
    exit 1
fi

# Clean up
echo "Cleaning up..."
rm -rf "$TEMP_DIR"

# Launch the app
echo "Launching BloxySpin..."
if ! open "$APP_PATH"; then
    echo "Failed to launch BloxySpin. Please try opening it manually from $APP_DIR."
    exit 1
fi

echo "-----------------------"
echo "The whole BloxySpin team wishes you luck on your bets!"
echo "Managed and developed by app.bloxyspin.com"
