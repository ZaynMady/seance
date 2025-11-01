#!/bin/bash

PROJECT_DIR=$1

# Validate project name
if [[ -z "$PROJECT_DIR" ]]; then
    echo "Usage: pyproject <project-name>"
    exit 1
fi

# Create project directory
echo "📁 Creating Python project: $PROJECT_DIR"
mkdir -p "$PROJECT_DIR"
cd "$PROJECT_DIR" || exit

# Create venv
echo "🐍 Creating virtual environment..."
python -m venv venv

# Activate environment (Windows/Linux/macOS)
if [[ -d "venv/Scripts" ]]; then
    source venv/Scripts/activate
else
    source venv/bin/activate
fi

# Upgrade pip
echo "⬆️  Upgrading pip..."
python -m pip install --upgrade pip

# Ask for dev tools
read -p "Install helpful dev tools (requests, rich, python-dotenv)? (y/n): " devtools
if [[ "$devtools" == "y" || "$devtools" == "Y" ]]; then
    echo "📦 Installing dev packages..."
    pip install requests rich python-dotenv
fi

# Create project structure
echo "📂 Creating project structure..."
mkdir -p src tests

cat <<EOF > src/main.py
def main():
    print("Hello from $PROJECT_DIR!")

if __name__ == "__main__":
    main()
EOF

touch requirements.txt

# Export installed packages (if any)
pip freeze > requirements.txt

# Create .gitignore
cat <<EOF > .gitignore
venv/
__pycache__/
*.pyc
.env
EOF

# Optional Git setup
read -p "Initialize git repository? (y/n): " gitinit
if [[ "$gitinit" == "y" || "$gitinit" == "Y" ]]; then
    git init
    echo "✅ Git initialized"
fi

echo ""
echo "🎉 Python project setup complete!"
echo "👉 Next steps:"
echo "cd $PROJECT_DIR"
echo "source venv/bin/activate   # Linux/Mac"
echo "venv\\Scripts\\activate    # Windows"
echo "python src/main.py"