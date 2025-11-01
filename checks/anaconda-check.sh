#!/bin/bash

# Check if conda exists
if command -v conda >/dev/null 2>&1; then
    conda_version=$(conda --version 2>&1)
    echo "✅ Found Anaconda/Miniconda: $conda_version"
    exit 0
else
    echo "❌ Conda not found!"
    read -p "Install Miniconda (recommended)? (y/n): " answer

    if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
        echo "📦 Installing Miniconda..."
        sleep 2
        ./installations/install-conda.sh
        sleep 2
        exit 0
    else
        echo "🔴 Conda is required for this data environment. Exiting."
        exit 1
    fi
fi
