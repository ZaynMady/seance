#!/usr/bin/env bash

set -e

# Detect OS
OS="$(uname -s)"

echo "Which Python distribution would you like to install?"
echo "1) Anaconda"
echo "2) Miniconda"
read -p "Enter choice (1 or 2): " CHOICE

if [ "$CHOICE" != "1" ] && [ "$CHOICE" != "2" ]; then
    echo "Invalid choice. Exiting."
    exit 1
fi

# URLs
if [ "$CHOICE" == "1" ]; then
    LINUX_URL="https://repo.anaconda.com/archive/Anaconda3-latest-Linux-x86_64.sh"
    MAC_URL="https://repo.anaconda.com/archive/Anaconda3-latest-MacOSX-x86_64.sh"
    WINDOWS_URL="https://repo.anaconda.com/archive/Anaconda3-latest-Windows-x86_64.exe"
else
    LINUX_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"
    MAC_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh"
    WINDOWS_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe"
fi

INSTALLER="conda-installer"

case "$OS" in
    Linux)
        URL="$LINUX_URL"
        INSTALLER+=".sh"
        ;;

    Darwin)
        URL="$MAC_URL"
        INSTALLER+=".sh"
        ;;

    MINGW*|CYGWIN*|MSYS*)
        echo "Detected Windows system."
        echo "Downloading Windows installer..."
        curl -L "$WINDOWS_URL" -o "$INSTALLER.exe"
        
        echo "✅ Download complete!"
        echo "Run the installer manually:"
        echo "   double-click $INSTALLER.exe"
        echo "Or use WSL and run this script again in Linux environment."
        exit 0
        ;;
        
    *)
        echo "Unsupported OS: $OS"
        exit 1
        ;;
esac

echo "Downloading installer..."
curl -L "$URL" -o "$INSTALLER"

echo "Running silent install..."
bash "$INSTALLER" -b -p "$HOME/conda3"

echo "Initializing conda..."
eval "$($HOME/conda3/bin/conda shell.bash hook)"
conda init

rm "$INSTALLER"
echo "✅ Installation complete! Restart your terminal."
