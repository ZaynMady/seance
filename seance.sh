#!/bin/bash

LANGUAGE="$1"
PROJECT_DIR="$2"

# Validate input
if [[ -z "$LANGUAGE" || -z "$PROJECT_DIR" ]]; then
    echo "Correct usage: seance <language> <project-dir>"
    exit 1
fi

# Python branch
if [[ "$LANGUAGE" = "python" ]]; then
    ./checks/python-check.sh
    STATUS=$?

    if [[ $STATUS -ne 0 ]]; then
        echo "Python is required for setup"
        exit 1
    else
        ./templates/pyproject.sh "$PROJECT_DIR"
    fi
fi
