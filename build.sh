#!/bin/bash
# Build script for Linux/macOS - Creates standalone executable

set -e

echo "🔮 Building Seance executable for $(uname)..."
echo ""

# Check if PyInstaller is installed
if ! python3 -c "import PyInstaller" 2>/dev/null; then
    echo "❌ PyInstaller not found. Installing..."
    pip3 install pyinstaller
fi

echo "✅ PyInstaller found"
echo ""

# Clean previous builds
rm -rf build dist seance.spec

echo "📦 Building executable..."
pyinstaller --onefile --name seance \
    --add-data "templates:templates" \
    --add-data "checks:checks" \
    --add-data "installations:installations" \
    --add-data "seance.sh:." \
    seance.py

echo ""
echo "✅ Build completed successfully!"
echo ""
echo "📁 Executable location: dist/seance"
echo ""
echo "📝 To add to PATH:"
echo "  sudo cp dist/seance /usr/local/bin/"
echo "  # Or for user-only installation:"
echo "  cp dist/seance ~/.local/bin/"
echo ""
echo "🧪 Test the executable:"
echo "  ./dist/seance python test-project"
echo ""
