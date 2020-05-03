#!/bin/bash
# hb_encode.sh



die() {
    echo "$program: $1" >&2
    exit ${2:-1}
}

escape_string() {
    echo "$1" | sed "s/'/'\\\''/g;/ /s/^\(.*\)$/'\1'/"
}

readonly program="$(basename "$0")"
readonly input="$1"

if [ ! "$input" ]; then
    die 'too few arguments'
fi

handbrake="HandBrakeCLI"

#extract framerate from file input name (if available)
frame_rate="$(echo "$input" | sed -n 's/.*\([0-9][0-9]\)fps.*/\1/p')"

readonly preset_option="$2"
handbrake_options=" --preset-import-file $preset_option.json -Z \"$preset_option\""
input_file="$(basename "$input")"
output="$(dirname "$input")/${input_file/%\.[^.]*/.mp4}" #.mp4

echo "frame rate: $frame_rate"
echo "preset $preset_option"
echo "handbrake options: $handbrake_options"

echo "Encoding: $input" >&2

#time "$handbrake" \
time \
echo "$handbrake" \
    "$handbrake_options" \
    --input "\"$input\"" \
    --output "\"$output\"" \
    --r "$frame_rate" --cfr \
   2>&1 | tee -a "${output}.log"