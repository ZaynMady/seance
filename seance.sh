#!/bin/bash

# Validate argument count
if [[ $# -gt 4 || $# -lt 2 ]]; then 
    echo "Usage: seance <language> <framework> <project-dir>"
    exit 1
fi

# Load vars
if [[ $# -eq 2 ]]; then
    LANGUAGE=$1
    PROJECT_DIR=$2
else
    LANGUAGE=$1
    FRAMEWORK=$2
    PROJECT_DIR=$3
fi

# ✅ Python branch
if [[ "$LANGUAGE" = "python" ]]; then
    ./checks/python-check.sh
    STATUS=$?

    if [[ $STATUS -ne 0 ]]; then
        echo "Python is required for setup"
        exit 1
    fi

    # ✅ Framework selection
    if [[ $# -eq 2 ]]; then
        ./templates/pyproject.sh "$PROJECT_DIR"
        exit 0
    elif [[ "$FRAMEWORK" = "flask" ]]; then
        ./templates/flaskpyproject.sh "$PROJECT_DIR"
        exit 0
    elif [[ "$FRAMEWORK" = "django" ]]; then
        ./templates/djangopyproject.sh "$PROJECT_DIR"
        exit 0
    elif [[ "$FRAMEWORK" = "anaconda" ]]; then
        ./templates/AnacondaDsPyproject.sh "$PROJECT_DIR"
        exit 0
    elif [[ "$FRAMEWORK" = "ds" ]]; then
        ./templates/DsPyProject.sh "$PROJECT_DIR"
        exit 0
    else
        echo "Framework not supported"
        exit 1
    fi

fi  # ✅ closes LANGUAGE = python
