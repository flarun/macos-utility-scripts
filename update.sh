#!/bin/bash

set -e

ROOT_DIR="$PWD"

echo "=== Step 1: Updating all Git repositories in subdirectories ==="
for d in "$ROOT_DIR"/*/ ; do
    if [ -d "$d/.git" ]; then
        echo "Updating Git repo in $d"
        (cd "$d" && git pull)
    fi
done

echo "=== Step 2: Updating Homebrew and packages ==="
if command -v brew >/dev/null 2>&1; then
    brew update && brew upgrade
    brew upgrade --cask
else
    echo "Homebrew not found. Skipping."
fi

echo "=== Step 3: Updating npm and global packages ==="
if command -v npm >/dev/null 2>&1; then
    npm install -g npm@latest
    npm update -g
else
    echo "npm not found. Skipping."
fi

echo "=== Step 4: Updating Conda packages ==="
if command -v conda >/dev/null 2>&1; then
    conda update --all -y
else
    echo "conda not found. Skipping."
fi

echo "=== Step 5: Updating Python versions via pyenv ==="
if command -v pyenv >/dev/null 2>&1; then
    brew upgrade pyenv
else
    echo "pyenv not found. Skipping."
fi

echo "=== Step 6: Updating Rust ==="
if command -v rustup >/dev/null 2>&1; then
    rustup update
else
    echo "rustup not found. Skipping."
fi

echo "=== Step 7: Updating yabai ==="
if brew list yabai &>/dev/null; then
    brew upgrade yabai
    brew services restart yabai
else
    echo "yabai not found. Skipping."
fi

echo "=== All updates complete! ==="
