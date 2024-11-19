#!/bin/bash

# Log file path
log_file="/home/ryan/juush_upload.log"

# Step 1: Capture a screenshot using gnome-screenshot and save it in "/home/ryan/screenshots/"
screenshot_dir="/home/ryan/screenshots"
mkdir -p "$screenshot_dir"
gnome-screenshot -a -f "${screenshot_dir}/$(date +%Y-%m-%d_%H-%M).png"

# Step 2: Find the newest image file in the "/home/ryan/screenshots/" folder
newest_file=$(ls -t "$screenshot_dir" | head -1)
image_path="${screenshot_dir}/${newest_file}"

# Step 3: Run 'juush' with the newest image and capture the output and error messages
juush file "$image_path" >> "$log_file" 2>> "$log_file"

# Step 4: Check the exit status of the previous command
if [ $? -eq 0 ]; then
  # 'juush file' command executed successfully
  notify-send "Juush Upload Successful" "Image uploaded successfully to Juush."
else
  # 'juush file' command encountered an error
  notify-send "Juush Upload Failed" "Uh oh stinky!"
fi

