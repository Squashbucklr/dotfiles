#!/bin/bash
wmctrl -i -r `wmctrl -l | grep -P "(monstro| - )Discord$" | awk {'print $1'}` -b add,demands_attention
