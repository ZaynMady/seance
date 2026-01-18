#!/bin/bash

PROJECT_DIR=$1

# Validate project name
if [[ -z "$PROJECT_DIR" ]]; then
    echo "Usage: dsproject <project-name>"
    exit 1
fi

echo "📁 Creating Data Science project: $PROJECT_DIR"
mkdir -p "$PROJECT_DIR"
cd "$PROJECT_DIR" || exit

echo "🐍 Creating virtual environment..."
python -m venv venv

# Activate environment (Windows/Linux/macOS)
if [[ -d "venv/Scripts" ]]; then
    source venv/Scripts/activate
else
    source venv/bin/activate
fi

echo "⬆️ Upgrading pip..."
python -m pip install --upgrade pip

# Ask for DS packages
read -p "Install common Data Science libraries (numpy, pandas, matplotlib, jupyter, scikit-learn)? (y/n): " dspkgs
if [[ "$dspkgs" == "y" || "$dspkgs" == "Y" ]]; then
    echo "📦 Installing data science packages..."
    pip install numpy pandas matplotlib seaborn scikit-learn jupyter notebook rich python-dotenv
fi

echo "📂 Creating project structure..."
mkdir -p data/raw data/processed notebooks src models reports

# main app entry
cat <<EOF > src/main.py
# Main script for $PROJECT_DIR
def main():
    print("Hello World")

if __name__ == "__main__":
    main()
EOF

# starter notebook
cat <<EOF > notebooks/analysis.ipynb
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# $PROJECT_DIR — Initial Analysis"
   ]
  },
  {
   "cell_type": "code",
   "metadata": {},
   "source": [
    "import pandas as pd\n",
    "import numpy as np"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python 3",
   "language": "python",
   "name": "python3"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
EOF

# requirements
pip freeze > requirements.txt

# .gitignore
cat <<EOF > .gitignore
venv/
__pycache__/
*.pyc
.env
.ipynb_checkpoints/
data/
models/
EOF

read -p "Initialize git repository? (y/n): " gitinit
if [[ "$gitinit" == "y" || "$gitinit" == "Y" ]]; then
    git init
    git add .
    git commit -m "Initial Data Science project setup"
    echo "✅ Git initialized"
fi

echo ""
echo "🎉 Data Science project setup complete!"
echo "👉 Next steps:"
echo "cd $PROJECT_DIR"
echo "source venv/bin/activate   # Linux/Mac"
echo "venv\\Scripts\\activate    # Windows"
echo "jupyter notebook"
