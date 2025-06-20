#!/usr/bin/env bash

# Compress all .mp4 files in _videos/ and save them to videos/ (preserve 1080p)
# Skip compression if the output file already exists

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

  # Skip if already compressed
  if [ -f "$dst" ]; then
    echo "🔁 Skipping $filename — already exists in $DST_DIR"
    continue
  fi

  echo "🔄 Compressing $filename …"
  ffmpeg -y -i "$src" \
    -c:v libx264 -crf "$CRF" -preset "$PRESET" \
    -c:a aac -b:a 160k \
    "$dst"

  echo "✅ Done: $dst"
done

echo "🎉 All videos processed!"
