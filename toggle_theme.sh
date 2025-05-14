#!/bin/sh

# Determine the current macOS theme using osascript
currentTheme=$(osascript -e 'tell application "System Events" to tell appearance preferences to return dark mode')

if [ "$currentTheme" = "true" ]; then
  # If the current theme is Dark, switch to Light
  echo "Switching to Light mode..."
  osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to false'
else
  # If the current theme is not Dark (thus Light), switch to Dark
  echo "Switching to Dark mode..."
  osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to true'
fi
  
