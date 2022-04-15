#!/bin/bash

pactl unload-module \
$(pactl list | grep -B 2 "sink_name=Master" | head -1 | cut -c 9-)
pactl unload-module \
$(pactl list | grep -B 2 "sink_name=VoiceChat" | head -1 | cut -c 9-)
pactl unload-module \
$(pactl list | grep -B 2 "sink_name=ScreenshareVolume" | head -1 | cut -c 9-)
pactl unload-module \
$(pactl list | grep -B 2 "sink_name=Screenshare" | head -1 | cut -c 9-)

pactl unload-module \
$(pactl list | grep -B 2 "source_name=MicAndScreenshare" | head -1 | cut -c 9-)
pactl unload-module \
$(pactl list | grep -B 2 "source_name=Microphone" | head -1 | cut -c 9-)

pactl load-module module-null-sink sink_name=Master
pactl load-module module-null-sink sink_name=VoiceChat
pactl load-module module-null-sink sink_name=ScreenshareVolume
pactl load-module module-null-sink sink_name=Screenshare

pactl load-module module-remap-source source_name=Microphone
pactl load-module module-remap-source source_name=MicAndScreenshare
