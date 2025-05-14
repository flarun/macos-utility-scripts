#!/bin/sh

# Store the current directory
ROOT_DIR="$PWD"

echo "=== Updating all git repositories in subdirectories ==="
for d in "$ROOT_DIR"/*/ ; do
    if [ -d "$d/.git" ]; then
        echo "Updating repo in $d"
        (cd "$d" && git pull)
    fi
done

echo "=== Updating Homebrew and packages ==="
brew update && brew upgrade

echo "=== Updating npm itself ==="
npm install -g npm@latest

echo "=== Updating all conda packages ==="
if command -v conda >/dev/null 2>&1; then
    conda update --all -y
else
    echo "conda: command not found. Skipping conda update."
fi

echo "=== All updates complete! ==="

