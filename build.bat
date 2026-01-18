@echo off
REM Build script for Windows - Creates standalone executable

echo 🔮 Building Seance executable for Windows...
echo.

REM Check if PyInstaller is installed
python -c "import PyInstaller" 2>nul
if errorlevel 1 (
    echo ❌ PyInstaller not found. Installing...
    pip install pyinstaller
    if errorlevel 1 (
        echo ❌ Failed to install PyInstaller
        exit /b 1
    )
)

echo ✅ PyInstaller found
echo.

REM Clean previous builds
if exist build rmdir /s /q build
if exist dist rmdir /s /q dist
if exist seance.spec del /q seance.spec

echo 📦 Building executable...
pyinstaller --onefile --name seance --add-data "templates;templates" --add-data "checks;checks" --add-data "installations;installations" --add-data "seance.sh;." seance.py

if errorlevel 1 (
    echo ❌ Build failed
    exit /b 1
)

echo.
echo ✅ Build completed successfully!
echo.
echo 📁 Executable location: dist\seance.exe
echo.
echo 📝 To add to PATH:
echo   1. Copy dist\seance.exe to a permanent location (e.g., C:\Program Files\Seance\)
echo   2. Add that directory to your PATH environment variable
echo   3. Or run: setx PATH "%%PATH%%;C:\Program Files\Seance"
echo.
echo 🧪 Test the executable:
echo   dist\seance.exe python test-project
echo.
