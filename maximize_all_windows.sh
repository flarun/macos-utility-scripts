#!/bin/bash

echo "🔄 Maximizing all resizable windows on all displays..."

if ! pgrep -x "yabai" > /dev/null; then
  echo "❌ yabai is not running."
  exit 1
fi

# Query all valid windows and loop
yabai -m query --windows | jq -c '.[] | select(."is-minimized" == false and ."can-move" == true and ."can-resize" == true)' | while read -r win; do
  win_id=$(echo "$win" | jq -r '.id')
  app=$(echo "$win" | jq -r '.app')
  display_id=$(echo "$win" | jq -r '.display')

  # Get frame for this display
  display_info=$(yabai -m query --displays | jq -c --arg disp "$display_id" '.[] | select(.index == ($disp | tonumber))')
  screen_x=$(echo "$display_info" | jq -r '.frame.x')
  screen_y=$(echo "$display_info" | jq -r '.frame.y')
  screen_w=$(echo "$display_info" | jq -r '.frame.w')
  screen_h=$(echo "$display_info" | jq -r '.frame.h')

  echo "🪟 [$app] window $win_id ➜ maximize on display $display_id → ${screen_w}x${screen_h} @ ${screen_x},${screen_y}"

  yabai -m window "$win_id" --move abs:"${screen_x}:${screen_y}"
  yabai -m window "$win_id" --resize abs:"${screen_w}:${screen_h}"
done

echo "✅ Done maximizing all windows."

