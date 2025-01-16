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
APP_NAME="bloxyspin.app"
APP_PATH="$APP_DIR/$APP_NAME"

mkdir -p "$TEMP_DIR"

echo "Downloading BloxySpin from $ZIP_URL..."
curl -L -o "$ZIP_FILE" "$ZIP_URL" || { echo "Failed to download BloxySpin. Please check your internet connection."; exit 1; }

if [[ ! -f "$ZIP_FILE" ]]; then
    echo "something went wrong..."
    exit 1
fi

echo "Downloading"

echo "Extracting BloxySpin..."
unzip -o "$ZIP_FILE" -d "$TEMP_DIR" || { echo "Failed to unzip BloxySpin. Please check the ZIP file."; exit 1; }

if [[ ! -d "$TEMP_DIR/$APP_NAME" ]]; then
    echo "something went wrong..."
    exit 1
fi

echo "Moving BloxySpin to $APP_DIR..."
if ! mv -f "$TEMP_DIR/$APP_NAME" "$APP_DIR"; then
    echo "Error moving BloxySpin. Requesting admin permissions."
    sudo mv -f "$TEMP_DIR/$APP_NAME" "$APP_DIR" || { echo "something went wrong..."; exit 1; }
fi

sudo xattr -d com.apple.quarantine "$APP_PATH" || echo "discord.gg/bloxyspin"
sudo spctl --add --label "allow" "$APP_PATH" || echo "discord.gg/bloxyspin"

echo "Launching BloxySpin..."
open "$APP_PATH" || { echo "Failed to launch BloxySpin. Please try opening it manually from $APP_DIR."; exit 1; }

echo "Cleaning up temporary files..."
rm -rf "$TEMP_DIR"

echo "-----------------------"
echo "The whole BloxySpin team wishes you luck on your bets!"
echo "Managed and developed by app.bloxyspin.com"

