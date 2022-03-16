#!/bin/bash
# Creating a new window is much faster than starting a new alacritty process.
# But at least one instance of alacritty must be running
alacritty msg create-window "$@" || alacritty "$@"
