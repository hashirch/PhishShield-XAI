#!/bin/bash
echo "Waiting for pip install to finish..."
while ps aux | grep "[p]ip install -r requirements.txt" > /dev/null; do
    sleep 5
done
echo "Pip install finished."
echo "Generating artifacts..."
./venv/bin/python scripts/generate_artifacts.py
echo "Starting backend API..."
./venv/bin/python -m src.api.app > backend.log 2>&1 &
echo "API Started."
