#!/bin/bash

PROJECT_DIR=$1

# Validate project name
if [[ -z "$PROJECT_DIR" ]]; then
    echo "Usage: djangopyproject <project-name>"
    exit 1
fi

# Create project directory
mkdir -p "$PROJECT_DIR"
cd "$PROJECT_DIR" || exit

echo "📁 Creating Django project: $PROJECT_DIR"

# Create virtual environment
echo "🐍 Creating virtual environment..."
python -m venv venv

# Activate venv
source venv/Scripts/activate 2>/dev/null || source venv/bin/activate

# Upgrade pip
python -m pip install --upgrade pip

# Install Django
echo "📦 Installing Django..."
pip install django

# Create Django project (root folder name same as project)
echo "⚙️ Initializing Django project..."
django-admin startproject "$PROJECT_DIR" .

# Optional: create app folder
read -p "Would you like to create a default app? (y/n): " createapp

if [[ "$createapp" == "y" || "$createapp" == "Y" ]]; then
    read -p "App name: " APP_NAME
    python manage.py startapp "$APP_NAME"
    echo "✅ App '$APP_NAME' created."
fi

# Optional Git init
read -p "Initialize git repository? (y/n): " gitinit

if [[ "$gitinit" == "y" || "$gitinit" == "Y" ]]; then
    git init
    echo "venv/" >> .gitignore
    echo "*.pyc" >> .gitignore
    echo "__pycache__/" >> .gitignore
    echo "✅ Git initialized & .gitignore created."
fi

echo ""
echo "Django project setup complete!"
echo "To start development:"
echo "cd $PROJECT_DIR"
echo "source venv/bin/activate  # or venv\\Scripts\\activate on Windows"
echo "python manage.py runserver"
