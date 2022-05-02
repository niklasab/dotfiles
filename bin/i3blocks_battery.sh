#!/bin/bash
# Only display battery percent for laptop
battery_percent=$(acpi -b | head -n1 | cut -d',' -f2 | xargs)
if [ -z $battery_percent ]; then
    echo -n ""
else
echo -n " $battery_percent"
fi
