#########################################################################################################
#                                    The bloxyspin installer @ macOS v0.0.1!                            #
#                                                                                                       #
#                                    This content belongs to app.bloxyspin.com                           #
#########################################################################################################

if [[ "$(uname)" != "Darwin" ]]; then
    echo "This is the BloxySpin macOS version, and should only be run on macOS. Please select" $(uname)
    exit 1
fi

TEMP_DIR="/tmp/spinnyinstaller"
APP_PATH="/Applications/bloxyspin.app"

echo "Hey, I'm Spinny - I will help you with the download."

echo "Please wait while I'm installing BloxySpin..."

DMG_URL="https://objects.githubusercontent.com/github-production-release-asset-2e65be/915188585/fbef1e03-57cb-4c6e-9ee9-3fc6b5f61909?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=releaseassetproduction%2F20250112%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250112T150021Z&X-Amz-Expires=300&X-Amz-Signature=bca63c5cc8e090fc64e30a340a303d170d38925918e5f46adab89ddca97ad0cd&X-Amz-SignedHeaders=host&response-content-disposition=attachment%3B%20filename%3DInstall.Spinny.dmg&response-content-type=application%2Foctet-stream"
echo "Downloading Spinny DMG..."
curl -L -o /tmp/Install.Spinny.dmg "$DMG_URL"

echo "Hey, I'm still here - Mounting the DMG..."
hdiutil attach /tmp/Install.Spinny.dmg -mountpoint "$TEMP_DIR"

echo "Installing the Spinny app..."
echo $TEMP_DIR # for logging xd
cp -r "$TEMP_DIR/bloxyspin.app" /Applications/

echo "Spin, Spinny, Spinnnnnnnny - Unmounting the DMG..."
hdiutil detach "$TEMP_DIR"

sudo xattr -d com.apple.quarantine /Applications/bloxyspin.app
sudo spctl --add --label "allow" /Applications/bloxyspin.app

echo "ALL DONE!"

open /Applications/bloxyspin.app

echo "-----------------------"
echo "The whole BloxySpin team wishes you luck on your bets!"
echo "Managed and developed by app.bloxyspin.com"
