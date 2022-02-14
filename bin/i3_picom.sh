#!/bin/bash
picom --config .config/picom.conf
# Workaround to make picom refresh, which avoids
# tearing issues at I3 restart.
touch .config/picom.conf
