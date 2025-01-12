#########################################################################################################
#                                    The bloxyspin installer @ macOS v0.0.1!                            #
#                                                                                                       #
#                                    This content belongs to app.bloxyspin.com                          #
#########################################################################################################
if [[ "$(uname)" != "Darwin" ]]; then
    echo "This script is for macOS only. your OS: $(uname)"
    exit 1
fi

# do not change -- ##
##
TEMP_DIR="$HOME/Downloads/BloxySpinInstaller"
ZIP_URL="https://github.com/leonielovesya/spinnyapp/releases/download/1.1.1/bloxyspin.zip"
ZIP_FILE="$TEMP_DIR/bloxyspin.zip"
APP_DIR="/Applications"
APP_PATH="$APP_DIR/bloxyspin.app"
##
# do not change -- ##

mkdir -p "$TEMP_DIR"

echo "Hey, I'm Spinny - I will help you with the download."
echo "Please wait while I'm installing BloxySpin..."

echo "Downloading BloxySpin..."
curl -L -o "$ZIP_FILE" "$ZIP_URL"

echo "Extracting BloxySpin..."
unzip -q "$ZIP_FILE" -d "$TEMP_DIR"

mv -f "$TEMP_DIR/bloxyspin.app" "$APP_PATH"

echo "Configuring app permissions..."
sudo xattr -d com.apple.quarantine "$APP_PATH"
sudo spctl --add --label "allow" "$APP_PATH"

echo "Cleaning up ..."
rm -rf "$TEMP_DIR"

echo "Launching BloxySpin..."
open "$APP_PATH"


echo "-----------------------"
echo "The whole BloxySpin team wishes you luck on your bets!"
echo "Managed and developed by app.bloxyspin.com"
