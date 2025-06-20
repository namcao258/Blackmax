#!/usr/bin/env bash

# Compress all .mp4 files in _videos/ and save them to videos/

SRC_DIR="_videos"
DST_DIR="videos"

mkdir -p "$DST_DIR"

# Encoding settings
CRF=23
PRESET="medium"

for src in "$SRC_DIR"/*.mp4; do
  if [ ! -f "$src" ]; then
    echo "No MP4 files found in $SRC_DIR"
    exit 1
  fi

  filename="$(basename "$src")"
  dst="$DST_DIR/$filename"

  echo "Compressing $src → $dst"

  ffmpeg -y -i "$src" \
    -vf "scale=-2:720" \
    -c:v libx264 -crf "$CRF" -preset "$PRESET" \
    -c:a aac -b:a 160k \
    "$dst"

  echo "✅ Done: $dst"
done

echo "All videos processed!"
