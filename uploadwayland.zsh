#!/bin/zsh

# Step 1: Define screenshot directory and output path
screenshot_dir="/home/ryan/screenshots"
mkdir -p "$screenshot_dir"
output_path="${screenshot_dir}/$(date +%Y-%m-%d_%H-%M).png"

# Step 2: Capture a region screenshot silently (no GUI)
spectacle --region --background --nonotify --output "$output_path"

# Step 3: Check if screenshot was created
if [ ! -f "$output_path" ]; then
  notify-send "Screenshot Failed" "No screenshot was captured."
  exit 1
fi

# Step 4: Upload using juush
URL=$(juush.zsh "$output_path")
exit_code=$?
PNG_PATH=$(basename "$URL")

# Step 5: Show success/failure notification
if [ $exit_code -eq 0 ]; then
  notify-send "Juush Upload Successful" "Image uploaded: $PNG_PATH"
else
  notify-send "Juush Upload Failed" "Uh oh stinky!"
fi
