#!/bin/bash
#feh --bg-max $HOME/.config/i3/desktop.png &
#exec xfce4-terminal &
bluetoothctl devices | grep 33:81:C4:15:D5:DF && bluetoothctl connect 33:81:C4:15:D5:DF
