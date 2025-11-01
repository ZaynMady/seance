#!/usr/bin/env bash

PROJECT_NAME=$1

# Validate input
if [[ -z "$PROJECT_NAME" ]]; then
    echo "Usage: condaproject <project-name>"
    exit 1
fi

echo "📁 Creating project: $PROJECT_NAME"
mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME" || exit

# Ask for Python version
read -p "Choose Python version (default 3.10): " PYV
PYV=${PYV:-3.10}

# Create Conda environment
echo "🐍 Creating conda environment..."
conda create -y -n "$PROJECT_NAME" python=$PYV

# Activate
echo "🔧 Activating environment..."
eval "$(conda shell.bash hook)"
conda activate "$PROJECT_NAME"

# Optional DS stack install
read -p "Install data-science packages (numpy, pandas, matplotlib, jupyter)? (y/n): " ds
if [[ "$ds" =~ ^[Yy]$ ]]; then
    echo "📦 Installing data-science packages..."
    conda install -y numpy pandas matplotlib jupyter seaborn scikit-learn
fi

# Create directory structure
echo "📂 Building folder structure..."
mkdir -p data notebooks src env

# Create files
cat <<EOF > src/main.py
def main():
    print("🚀 $PROJECT_NAME project ready using Conda!")

if __name__ == "__main__":
    main()
EOF

cat <<EOF > notebooks/analysis.ipynb
{}
EOF

# Export env file
echo "📄 Exporting environment.yml"
conda env export > environment.yml

# .gitignore
cat <<EOF > .gitignore
# Conda environments
env/
*.egg-info/
__pycache__/
.ipynb_checkpoints/
.DS_Store
EOF

# Git init
read -p "Initialize Git? (y/n): " git
if [[ "$git" =~ ^[Yy]$ ]]; then
    git init
    echo "✅ Git repo initialized"
fi

echo ""
echo "🎉 Conda DS project created!"
echo "👉 Next steps:"
echo "cd $PROJECT_NAME"
echo "conda activate $PROJECT_NAME"
echo "jupyter notebook"