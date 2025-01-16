#########################################################################################################
#                                    The BloxySpin Installer @ macOS v0.0.1!                           #
#                                                                                                       #
#                                    This content belongs to app.bloxyspin.com                         #
#########################################################################################################

if [[ "$(uname)" != "Darwin" ]]; then
    echo "This script is for macOS only. Your OS: $(uname)"
    exit 1
fi

TEMP_DIR="$HOME/Downloads/BloxySpinInstaller"
ZIP_URL="https://github.com/leonielovesya/spinnyapp/releases/download/1.1.1/bloxyspin.zip"
ZIP_FILE="$TEMP_DIR/bloxyspin.zip"
APP_DIR="/Applications"
APP_PATH="$APP_DIR/bloxyspin.app"

mkdir -p "$TEMP_DIR"
echo "Temp directory created at: $TEMP_DIR"

# Download BloxySpin
echo "Downloading BloxySpin from $ZIP_URL..."
curl -L -o "$ZIP_FILE" "$ZIP_URL" || { echo "Failed to download BloxySpin. Please check your internet connection."; exit 1; }

if [[ ! -f "$ZIP_FILE" ]]; then
    echo "ZIP file not found..."
    exit 1
fi

echo "ZIP file downloaded successfully."

echo "Moving BloxySpin to $APP_DIR..."
if ! mv -f "$ZIP_FILE" "$APP_DIR"; then
    echo "Error moving the ZIP file. Requesting admin permissions."
    sudo mv -f "$ZIP_FILE" "$APP_DIR" || { echo "Failed to move the ZIP file to $APP_DIR even with admin permissions."; exit 1; }
fi

echo "ZIP file successfully moved to Applications."

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

echo "Launching BloxySpin..."
open "$APP_PATH" || { echo "Failed to launch BloxySpin. Please try opening it manually from $APP_DIR."; exit 1; }

echo "-----------------------"
echo "The whole BloxySpin team wishes you luck on your bets!"
echo "Managed and developed by app.bloxyspin.com"
