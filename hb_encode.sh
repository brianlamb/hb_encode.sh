#!/usr/bin/env bash

for file in *.mov
do
echo $file

input_file_source="${file##*/}" # strip path

input_file_noextension="${input_file_source%\.[^.]*}" #strip extension

input_file_extension="${input_file_source##*.}" #extract origninal extension

output_extension="mp4"

input_file_converted="${input_file_noextension}.${output_extension}"

output_metadata_fixed="fixed-${input_file_converted}" 


##outputdir=$(dirname "${input}")
##output="$(basename "$input")"
##output="${outputdir}/${output%.[^.]*}.mp4"

# build up optional handbrake options beyond our preset
handbrake_options="--audio-copy-mask aac --aencoder copy:aac "
handbrake_options="$handbrake_options --optimize"
handbrake_options="$handbrake_options --pfr 60"

HandBrakeCLI --preset-import-file ../HB1440-60PFR-SlowerRF20.json -Z "My1440-60PFR-Slower-RF20-AACpassthrough-optimizedatom" `${handbrake_options}` -i "${input_file_source}" -o "${input_file_converted}"
###for i in *.avi; do ffmpeg -i "$i" "${i%.*}.mp4"; done


# ...copy metadata over...
# copy stream
ffmpeg \
-i "$input_file_source" \
-i "$input_file_converted" \
-map_metadata:g 0:g \
-map_metadata:s:0 0:s:0 \
-map_metadata:s:1 0:s:1 \
-metadata converted="True" \
-map 1 \
-codec copy \
-movflags use_metadata_tags \
"${output_metadata_fixed}"


touch -r "$input_file_source" "$output_metadata_fixed" 
done

