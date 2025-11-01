#!/usr/bin/env bash
set -e

OS="$(uname -s)"

echo "🔍 Detecting system..."
echo "OS Detected: $OS"
echo ""

install_linux() {
    echo "🐧 Installing Python on Linux..."
    
    if command -v apt-get >/dev/null 2>&1; then
        sudo apt-get update
        sudo apt-get install -y python3 python3-pip python3-venv
    elif command -v yum >/dev/null 2>&1; then
        sudo yum install -y python3 python3-pip
    else
        echo "❌ Unsupported Linux package manager. Install Python manually."
        exit 1
    fi
}

install_macos() {
    echo "🍎 Installing Python on macOS..."

    if ! command -v brew >/dev/null 2>&1; then
        echo "Homebrew not found. Installing Homebrew first..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        eval "$(/opt/homebrew/bin/brew shellenv)" 2>/dev/null || eval "$(/usr/local/bin/brew shellenv)"
    fi

    brew update
    brew install python
}

install_windows() {
    echo "🪟 Installing Python on Windows through winget..."
    
    # winget will handle architecture and version
    winget install --silent Python.Python.3

    sleep 2
}

case "$OS" in
    Linux)
        install_linux
        ;;
    Darwin)
        install_macos
        ;;
    MINGW*|CYGWIN*|MSYS*)
        install_windows
        ;;
    *)
        echo "❌ Unsupported OS: $OS"
        exit 1
        ;;
esac

echo ""
echo "✅ Verifying Python installation..."
if command -v python3 >/dev/null 2>&1; then
    PY="python3"
elif command -v python >/dev/null 2>&1; then
    PY="python"
else
    echo "❌ Python installation failed."
    exit 1
fi

$PY --version
echo "🎉 Python installed successfully!"
