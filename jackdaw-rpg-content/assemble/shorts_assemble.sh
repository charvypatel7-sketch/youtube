#!/usr/bin/env bash
# Build 5 vertical YouTube Shorts (1080x1920) from the generated pieces.
#
# Download each Short's files from your Higgsfield account into this folder,
# named exactly like this (clip A, clip B, voiceover):
#   s1a.mp4 s1b.mp4 s1_vo.mp3      (Short 1 - "It was fine")
#   s2a.mp4 s2b.mp4 s2_vo.mp3      (Short 2 - tighter cast)
#   s3a.mp4 s3b.mp4 s3_vo.mp3      (Short 3 - silence)
#   s4a.mp4 s4b.mp4 s4_vo.mp3      (Short 4 - choices)
#   s5a.mp4 s5b.mp4 s5_vo.mp3      (Short 5 - nostalgia)
# Then run:  bash shorts_assemble.sh
# Output: short1.mp4 ... short5.mp4

set -e
for n in 1 2 3 4 5; do
  a="s${n}a.mp4"; b="s${n}b.mp4"; vo="s${n}_vo.mp3"; out="short${n}.mp4"
  if [[ ! -f "$a" || ! -f "$b" || ! -f "$vo" ]]; then
    echo "SKIP short${n}: missing $a/$b/$vo"; continue
  fi
  # concat the two vertical clips -> silent 1080x1920 video
  ffmpeg -y -i "$a" -i "$b" \
    -filter_complex "[0:v]scale=1080:1920,setsar=1[v0];[1:v]scale=1080:1920,setsar=1[v1];[v0][v1]concat=n=2:v=1:a=0[v]" \
    -map "[v]" -an -c:v libx264 -crf 18 -pix_fmt yuv420p "_tmp_${n}.mp4"
  # lay the voiceover on top; hold last frame if VO is longer; end with the narration
  ffmpeg -y -i "_tmp_${n}.mp4" -i "$vo" \
    -filter_complex "[0:v]tpad=stop_mode=clone:stop_duration=8[v]" \
    -map "[v]" -map 1:a -c:v libx264 -crf 18 -pix_fmt yuv420p -c:a aac -b:a 192k -shortest "$out"
  rm -f "_tmp_${n}.mp4"
  echo "built $out"
done
echo "All done."
