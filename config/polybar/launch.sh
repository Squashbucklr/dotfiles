#!/bin/bash

killall -q polybar
sleep 0.2

if type "xrandr"; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m \
        DEFAULT_NETWORK_INTERFACE=$(ip route | grep '^default' | awk '{print $5}' | head -n1) \
        polybar --reload top | tee -a /tmp/polybar.log & disown
    done
else
    DEFAULT_NETWORK_INTERFACE=$(ip route | grep '^default' | awk '{print $5}' | head -n1) \
    polybar --reload top | tee -a /tmp/polybar.log & disown
fi
