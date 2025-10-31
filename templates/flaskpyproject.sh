#!/bin/bash

PROJECT_NAME=$1

# Validate input
if [[ -z "$PROJECT_NAME" ]]; then
    echo "❌ Usage: ./flask-init.sh <project_name>"
    exit 1
fi

echo "📁 Creating project folder: $PROJECT_NAME"
mkdir "$PROJECT_NAME"
cd "$PROJECT_NAME" || exit

echo "🐍 Creating virtual environment..."
python -m venv venv || python3 -m venv venv

# Activate virtual env (Linux, macOS, WSL, Git Bash)
source venv/bin/activate 2>/dev/null || source venv/Scripts/activate

echo "📦 Installing Flask..."
pip install Flask

echo "📦 Saving dependencies..."
pip freeze > requirements.txt

# Create proper Flask structure
echo "📂 Creating Flask folder structure..."

mkdir app
mkdir app/templates

# Create __init__.py
cat <<EOF > app/__init__.py
from flask import Flask

def create_app():
    app = Flask(__name__)
    
    from .routes import main
    app.register_blueprint(main)
    
    return app
EOF

# Create routes.py
cat <<EOF > app/routes.py
from flask import Blueprint, render_template

main = Blueprint("main", __name__)

@main.route("/")
def home():
    return render_template("index.html")
EOF

# Create template
cat <<EOF > app/templates/index.html
<!DOCTYPE html>
<html>
<head>
    <title>Flask App</title>
</head>
<body>
    <h1>Hello from Flask!</h1>
</body>
</html>
EOF

# Create run.py
cat <<EOF > run.py
from app import create_app

app = create_app()

if __name__ == "__main__":
    app.run(debug=True)
EOF

echo " Flask project created!"
echo " Directory: $PROJECT_NAME"
echo ""
echo " To run your Flask app:"
echo "---------------------------------"
echo "cd $PROJECT_NAME"
echo "source venv/bin/activate   # Windows: venv\\Scripts\\activate"
echo "python run.py"
echo "---------------------------------"

# Ask if user wants git init
read -p "Initialize Git? (y/n): " git_ans
if [[ $git_ans == "y" || $git_ans == "Y" ]]; then
    git init -q
    echo "venv/" > .gitignore
    echo "... Git repo initialized"
else
    echo "... Skipping Git setup"
fi

# Ask to run immediately
read -p "▶️ Run app now? (y/n): " run_ans
if [[ $run_ans == "y" || $run_ans == "Y" ]]; then
    python run.py
fi
