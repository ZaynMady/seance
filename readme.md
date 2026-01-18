# Seance - Project Scaffolding Tool

A cross-platform command-line tool for scaffolding Python projects with various frameworks.

## Installation

### Option 1: Install from source (Linux/macOS)

```bash
# Clone or download the repository
cd seance

# Install globally (requires sudo)
sudo ./install.sh

# Or install to user directory (no sudo required)
INSTALL_DIR=~/.local/bin ./install.sh
```

Make sure `~/.local/bin` is in your PATH for user installations.

### Option 2: Use Python wrapper (Windows/Linux/macOS)

```bash
# Make the Python script executable (Linux/macOS)
chmod +x seance.py

# Run directly
python seance.py python my-project
```

### Option 3: Build standalone executable

See the "Building Executables" section below.

## Usage

```bash
seance <language> [framework] <project-dir>

# Examples:
seance python my-project                  # Basic Python project
seance python flask my-flask-app          # Flask web app
seance python django my-django-app        # Django web app
seance python anaconda my-ds-project      # Anaconda data science project
seance python ds my-datascience-project   # Data science project
```

## Building Executables

### Prerequisites

```bash
pip install pyinstaller
```

### Build for your platform

```bash
# Windows
pyinstaller --onefile --name seance --add-data "templates;templates" --add-data "checks;checks" --add-data "installations;installations" --add-data "seance.sh;." seance.py

# Linux/macOS
pyinstaller --onefile --name seance --add-data "templates:templates" --add-data "checks:checks" --add-data "installations:installations" --add-data "seance.sh:." seance.py
```

The executable will be in the `dist/` folder.

### Add to PATH

#### Windows
1. Copy `dist\seance.exe` to a directory (e.g., `C:\Program Files\Seance\`)
2. Add that directory to your PATH:
   - Open System Properties → Environment Variables
   - Edit PATH and add your directory
   - Or use PowerShell: `[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\Program Files\Seance", "User")`

#### Linux/macOS
```bash
# Copy to a directory in PATH
sudo cp dist/seance /usr/local/bin/
# Or for user-only installation
cp dist/seance ~/.local/bin/
```

## Requirements

- Bash (on Windows: Git Bash or WSL)
- Python 3.6+ (for Python wrapper)

## Supported Languages & Frameworks

- **Python**
  - Basic Python project
  - Flask web framework
  - Django web framework
  - Anaconda data science
  - Data science (without Anaconda)

## License

[Your License Here]
