# hb_encode.sh
handbrake encoding script
Originally forked but nearly totally rewritten with a different focus other than analyzing the inputs for framerates and size considerations
Instead focus on re-encoding and maintaining metadata integrity from original file
 -File input check (usually expects MOV input and MP4 output - but some source might already be MP4
 -Allow HD/xHD up to 1440p 60fps (PFR)
 -unconcerned with audio, expect 2 track stereo - either copy aac, or encode as aac
 
## Requirements
bash 
HandBrakeCLI
ffmpeg / ffprobe

### Encodes input files to smaller storage, maintains metadata and file timestamps from originals, tags converted with metadata "Converted"

