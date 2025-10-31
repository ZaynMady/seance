#!/bin/bash

winget install Python.Python.3

sleep 1

if command -v python >/dev/null 2>&1; then
    pyversion=$(python --version 2>&1)
    echo "installed: $pyversion" ]]
else 
    echo "error during installation"
fi