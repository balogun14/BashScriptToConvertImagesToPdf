#!/bin/bash

if ! command -v convert &> /dev/null; then
    echo "ImageMagick is not installed. Please install it first."
    exit 1
fi

# Set the compression quality (0-100, where 100 is the best quality)
compression_quality=50

# Process images in batches
batch_size=50
total_images=$(ls *.jpeg | wc -l)
batches=$((total_images / batch_size + 1))

for ((i = 0; i < batches; i++)); do
    start=$((i * batch_size + 1))
    end=$((start + batch_size - 1))
    images_batch=$(ls *.jpeg | sed -n "${start},${end}p")

    if [ -n "${images_batch}" ]; then
        convert -colorspace gray -quality ${compression_quality} ${images_batch} output_batch_${i}.pdf
    fi
done

echo "Conversion complete. PDF files: output_batch_*.pdf"
