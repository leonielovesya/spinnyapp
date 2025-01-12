#########################################################################################################
#                                    The BloxySpin Installer @ macOS v0.0.1!                           #
#                                                                                                       #
#                                    This content belongs to app.bloxyspin.com                         #
#########################################################################################################

# Check macOS
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
echo "Temp directory created at: $TEMP_DIR"

# Download BloxySpin
echo "Downloading BloxySpin from $ZIP_URL..."
curl -L -o "$ZIP_FILE" "$ZIP_URL" || { echo "Failed to download BloxySpin. Please check your internet connection."; exit 1; }

# Check if ZIP file exists
if [[ ! -f "$ZIP_FILE" ]]; then
    echo "ZIP file not found. Please check the download URL."
    exit 1
fi

echo "ZIP file downloaded successfully."

# Remove any previous conflicting files
echo "Cleaning up previous installations and hidden files..."
rm -rf "$TEMP_DIR/__MACOSX" "$TEMP_DIR/bloxyspin.app"
find "$TEMP_DIR" -name '._*' -exec rm -f {} \;

# Extract BloxySpin
echo "Extracting BloxySpin from $ZIP_FILE..."
unzip -q "$ZIP_FILE" -d "$TEMP_DIR" || { echo "Failed to extract BloxySpin. Please check the ZIP file."; exit 1; }

echo "Extraction successful."

# Move app to Applications directory, requesting admin permissions if necessary
echo "Moving BloxySpin to $APP_DIR..."
if ! mv -f "$TEMP_DIR/bloxyspin.app" "$APP_PATH"; then
    echo "Error moving the app. Requesting admin permissions."
    sudo mv -f "$TEMP_DIR/bloxyspin.app" "$APP_PATH" || { echo "Failed to move the app to $APP_DIR even with admin permissions."; exit 1; }
fi

echo "App successfully moved to Applications."

# Configure app permissions
echo "Configuring app permissions..."
if ! sudo xattr -d com.apple.quarantine "$APP_PATH"; then
    echo "Failed to remove quarantine attribute from $APP_PATH."
    exit 1
fi

if ! sudo spctl --add --label "allow" "$APP_PATH"; then
    echo "Failed to add security exception for $APP_PATH."
    exit 1
fi

echo "Permissions successfully configured."

# Clean up
echo "Cleaning up temporary files..."
rm -rf "$TEMP_DIR"
echo "Temporary files cleaned."

# Launch the app
echo "Launching BloxySpin..."
open "$APP_PATH" || { echo "Failed to launch BloxySpin. Please try opening it manually from $APP_DIR."; exit 1; }

echo "-----------------------"
echo "The whole BloxySpin team wishes you luck on your bets!"
echo "Managed and developed by app.bloxyspin.com"
