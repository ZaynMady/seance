#!/usr/bin/env python3
"""
Seance - Project Scaffolding Tool
Cross-platform wrapper for the seance bash scripts
"""

import os
import sys
import subprocess
import platform
from pathlib import Path

# Get the directory where this script is located
SEANCE_HOME = Path(__file__).parent.resolve()

def run_seance(args):
    """Run the seance.sh script with the given arguments"""
    script_path = SEANCE_HOME / "seance.sh"
    
    # Save the user's current working directory
    user_cwd = os.getcwd()
    
    # Convert the project directory (last argument) to an absolute path
    # This ensures the project is created in the user's current directory
    if args:
        modified_args = list(args)
        # The last argument is always the project directory
        project_dir = modified_args[-1]
        
        # Convert to absolute path if it's relative
        if not os.path.isabs(project_dir):
            absolute_project_dir = os.path.join(user_cwd, project_dir)
            modified_args[-1] = absolute_project_dir
        
        args = modified_args
    
    # Check if we're on Windows
    if platform.system() == "Windows":
        # Use Git Bash or WSL if available
        bash_paths = [
            r"C:\Program Files\Git\bin\bash.exe",
            r"C:\Program Files (x86)\Git\bin\bash.exe",
            "bash.exe",  # Try PATH
            "wsl.exe",   # Windows Subsystem for Linux
        ]
        
        bash_cmd = None
        for bash_path in bash_paths:
            try:
                result = subprocess.run(
                    [bash_path, "--version"], 
                    capture_output=True, 
                    timeout=5
                )
                if result.returncode == 0:
                    bash_cmd = bash_path
                    break
            except (FileNotFoundError, subprocess.TimeoutExpired):
                continue
        
        if not bash_cmd:
            print("❌ Error: Bash is required to run seance on Windows")
            print("Please install one of the following:")
            print("  - Git for Windows (https://git-scm.com/download/win)")
            print("  - Windows Subsystem for Linux (WSL)")
            sys.exit(1)
        
        # Run with bash
        cmd = [bash_cmd, str(script_path)] + args
    else:
        # Unix-like system (Linux, macOS)
        cmd = [str(script_path)] + args
    
    try:
        # Run from SEANCE_HOME so relative paths in bash scripts work
        result = subprocess.run(cmd, cwd=SEANCE_HOME)
        sys.exit(result.returncode)
    except Exception as e:
        print(f"❌ Error running seance: {e}")
        sys.exit(1)

def main():
    """Main entry point"""
    if len(sys.argv) < 2:
        print("Usage: seance <language> [framework] <project-dir>")
        print("\nExamples:")
        print("  seance python my-project")
        print("  seance python flask my-flask-app")
        print("  seance python django my-django-app")
        print("  seance python anaconda my-ds-project")
        print("  seance python ds my-datascience-project")
        sys.exit(1)
    
    # Pass all arguments except the script name
    run_seance(sys.argv[1:])

if __name__ == "__main__":
    main()
