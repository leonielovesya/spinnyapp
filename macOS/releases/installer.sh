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
ZIP_URL="https://objects.githubusercontent.com/github-production-release-asset-2e65be/915188585/30d5ccaa-fb4a-4a74-aeea-b599fbe33227?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=releaseassetproduction%2F20250112%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250112T163402Z&X-Amz-Expires=300&X-Amz-Signature=6b18a3a417f31749aa87a61fbbaea4f996727620a1df88d7a689ce658ada66c0&X-Amz-SignedHeaders=host&response-content-disposition=attachment%3B%20filename%3Dbloxyspin.zip&response-content-type=application%2Foctet-stream"
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
