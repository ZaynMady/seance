#!/bin/bash

# Seance Installation Script
# Installs seance globally to /usr/local/bin (or custom location)

set -e

# Default installation directory
INSTALL_DIR="${INSTALL_DIR:-/usr/local/bin}"
SEANCE_HOME="${SEANCE_HOME:-/usr/local/lib/seance}"

echo "🔮 Installing Seance..."
echo "Installation directory: $INSTALL_DIR"
echo "Seance home: $SEANCE_HOME"

# Check if running with sufficient permissions
if [[ ! -w "$INSTALL_DIR" ]]; then
    echo "❌ Error: No write permission to $INSTALL_DIR"
    echo "Please run with sudo or choose a different installation directory:"
    echo "  INSTALL_DIR=~/.local/bin ./install.sh"
    exit 1
fi

# Create seance home directory
echo "📁 Creating seance directory..."
mkdir -p "$SEANCE_HOME"

# Copy all files
echo "📦 Copying files..."
cp -r templates checks installations "$SEANCE_HOME/"
cp seance.sh "$SEANCE_HOME/"
chmod +x "$SEANCE_HOME/seance.sh"

# Make all template scripts executable
chmod +x "$SEANCE_HOME"/templates/*.sh
chmod +x "$SEANCE_HOME"/checks/*.sh
chmod +x "$SEANCE_HOME"/installations/*.sh

# Create wrapper script in bin directory
echo "🔗 Creating seance command..."
cat > "$INSTALL_DIR/seance" << 'EOF'
#!/bin/bash
# Seance wrapper script
SEANCE_HOME="${SEANCE_HOME:-/usr/local/lib/seance}"
cd "$SEANCE_HOME" && ./seance.sh "$@"
EOF

chmod +x "$INSTALL_DIR/seance"

echo "✅ Seance installed successfully!"
echo ""
echo "Usage: seance <language> [framework] <project-dir>"
echo "Example: seance python flask my-project"
echo ""
echo "To uninstall, run: sudo rm -rf $SEANCE_HOME $INSTALL_DIR/seance"
