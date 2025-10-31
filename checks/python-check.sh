#!/bin/bash

# Check if python exists
if command -v python >/dev/null 2>&1; then
    pyversion=$(python --version 2>&1)
    echo "Found Python: $pyversion"
else
    echo "Python not found!"
    read -p "Install latest version of Python? (y/n): " answer

    if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
        echo " Installing Python..."
        sleep 2
        ./installations/install-python.sh
        sleep 2
        echo " Python installed!"
    else
        echo " Python is required. Exiting."
        exit 1
    fi
fi
