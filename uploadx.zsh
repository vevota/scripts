#!/bin/zsh

# Step 1: Capture a screenshot using maim with slop and save it in "/home/ryan/screenshots/"
screenshot_dir="/home/ryan/screenshots"
mkdir -p "$screenshot_dir"
output_path="${screenshot_dir}/$(date +%Y-%m-%d_%H-%M).png"

# Use slop to select a region and maim to capture it
maim -s "$output_path"

# Check if maim successfully captured a screenshot
if [ ! -f "$output_path" ]; then
  notify-send "Screenshot Failed" "No screenshot was captured."
  exit 1
fi

# Step 2: Find the newest image file in the "/home/ryan/screenshots/" folder
newest_file=$(ls -t "$screenshot_dir" | head -1)
image_path="${screenshot_dir}/${newest_file}"

# Step 3: Run 'juush' with the newest image and capture the output and error messages
URL=$(juush "$image_path")
PNG_PATH=$(basename "$URL")

# Step 4: Check the exit status of the previous command
if [ $? -eq 0 ]; then
  # 'juush file' command executed successfully
  notify-send "Juush Upload Successful $PNG_PATH" "Image uploaded successfully to Juush $PNG_PATH"
else
  # 'juush file' command encountered an error
  notify-send "Juush Upload Failed" "Uh oh stinky!"
fi

