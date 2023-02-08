#!/bin/bash

pactl unload-module \
$(pactl list | grep -B 2 "sink_name=Master" | head -1 | cut -c 9-)
pactl unload-module \
$(pactl list | grep -B 2 "sink_name=Default" | head -1 | cut -c 9-)
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
pactl unload-module \
$(pactl list | grep -B 2 "source_name=ScreenshareSource" | head -1 | cut -c 9-)


pactl load-module module-null-sink sink_name=Master
pactl load-module module-null-sink sink_name=Default
pactl load-module module-null-sink sink_name=VoiceChat
pactl load-module module-null-sink sink_name=ScreenshareVolume
pactl load-module module-null-sink sink_name=Screenshare

pactl load-module module-remap-source source_name=Microphone
pactl load-module module-remap-source source_name=MicAndScreenshare
pactl load-module module-remap-source source_name=ScreenshareSource

outputs=( Master:monitor_FL Master:monitor_FR Default:monitor_FL \
       Default:monitor_FR VoiceChat:monitor_FL VoiceChat:monitor_FR \
       ScreenshareVolume:monitor_FL ScreenshareVolume:monitor_FR \
       Screenshare:monitor_FL Screenshare:monitor_FR \
       input.Microphone:monitor_FL input.Microphone:monitor_FR \
       Microphone:capture_FL Microphone:capture_FR \
       input.MicAndScreenshare:monitor_FL input.MicAndScreenshare:monitor_FR \
       MicAndScreenshare:capture_FL MicAndScreenshare:capture_FR \
       input.ScreenshareSource:monitor_FL input.ScreenshareSource:monitor_FR \
       ScreenshareSource:capture_FL ScreenshareSource:capture_FR )

inputs=( Master:playback_FL Master:playback_FR Default:playback_FL \
         Default:playback_FR VoiceChat:playback_FL VoiceChat:playback_FR \
         ScreenshareVolume:playback_FL ScreenshareVolume:playback_FR \
         Screenshare:playback_FL Screenshare:playback_FR \
         input.Microphone:input_FL input.Microphone:input_FR \
         input.MicAndScreenshare:input_FL input.MicAndScreenshare:input_FR \
         input.ScreenshareSource:input_FL input.ScreenshareSource:input_FR )

for i in "${outputs[@]}"
do
    for j in "${inputs[@]}"
    do
        pw-link -d $i $j 2> /dev/null
    done
done

pw-link Master:monitor_FL \
        alsa_output.pci-0000_08_00.4.analog-stereo:playback_FL
pw-link Master:monitor_FR \
        alsa_output.pci-0000_08_00.4.analog-stereo:playback_FR
pw-link alsa_input.usb-Focusrite_Scarlett_Solo_USB-00.analog-stereo:capture_FL \
        input.Microphone:input_FL
pw-link alsa_input.usb-Focusrite_Scarlett_Solo_USB-00.analog-stereo:capture_FR \
        input.Microphone:input_FR

pw-link Default:monitor_FL Master:playback_FL
pw-link Default:monitor_FR Master:playback_FR
pw-link VoiceChat:monitor_FL Master:playback_FL
pw-link VoiceChat:monitor_FR Master:playback_FR
pw-link Screenshare:monitor_FL Master:playback_FL
pw-link Screenshare:monitor_FR Master:playback_FR
pw-link Screenshare:monitor_FL ScreenshareVolume:playback_FL
pw-link Screenshare:monitor_FR ScreenshareVolume:playback_FR
pw-link Screenshare:monitor_FL input.ScreenshareSource:input_FL
pw-link Screenshare:monitor_FR input.ScreenshareSource:input_FR
pw-link input.Microphone:monitor_FL input.MicAndScreenshare:input_FL
pw-link input.Microphone:monitor_FR input.MicAndScreenshare:input_FR
pw-link ScreenshareVolume:monitor_FL input.MicAndScreenshare:input_FL
pw-link ScreenshareVolume:monitor_FR input.MicAndScreenshare:input_FR

