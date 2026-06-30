#!/usr/bin/env bash
# Assemble the Jackdaw-style teaser.
# 1) Download the 3 files from your Higgsfield account into this folder, named:
#      clip1.mp4   (lone figure at the galaxy window)
#      clip2.mp4   (steaming mug of tea on the console)
#      vo.mp3      (Alistair voiceover)
# 2) Run:  bash assemble_teaser.sh
# Output: teaser_1080p.mp4  (1080p, voiceover over the two clips)

set -e

# Concatenate the two silent clips into one 24s 1080p video
ffmpeg -y -i clip1.mp4 -i clip2.mp4 \
  -filter_complex "[0:v]scale=1920:1080,setsar=1[v0];[1:v]scale=1920:1080,setsar=1[v1];[v0][v1]concat=n=2:v=1:a=0[v]" \
  -map "[v]" -an -c:v libx264 -crf 18 -pix_fmt yuv420p video_silent.mp4

# Lay the voiceover on top; hold the last frame if the VO runs slightly longer,
# and end exactly when the narration ends.
ffmpeg -y -i video_silent.mp4 -i vo.mp3 \
  -filter_complex "[0:v]tpad=stop_mode=clone:stop_duration=8[v]" \
  -map "[v]" -map 1:a \
  -c:v libx264 -crf 18 -pix_fmt yuv420p -c:a aac -b:a 192k -shortest \
  teaser_1080p.mp4

echo "Done -> teaser_1080p.mp4"
