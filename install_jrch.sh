#!/bin/sh
set -e

# Get the path to the jrch folder
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
JRCH_DIR="$SCRIPT_DIR/jrch"

# Check if the jrch folder exists
if [ ! -d "$JRCH_DIR" ]; then
    echo "Error: jrch/ folder not found!"
    exit 1
fi

# Check if Go is installed
if ! command -v go >/dev/null 2>&1; then
    echo "Error: Go is not installed. Please install it using your package manager."
    exit 1
fi

echo "Compiling jrch..."
cd "$JRCH_DIR"
go build -o jrch .

INSTALL_DIR="/usr/local/bin"
echo "Installing jrch to $INSTALL_DIR..."
mv jrch "$INSTALL_DIR/"
chmod +x "$INSTALL_DIR/jrch"

echo "jrch was successfully installed to $INSTALL_DIR"
echo "You can run it using the command: jrch"

