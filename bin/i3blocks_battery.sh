# Only display battery percent for laptop
battery_percent=$(acpi -b | head -n1 | cut -d',' -f2 | xargs)
if [ -z $battery_percent ]; then
    echo ""
else
    echo " $battery_percent"
fi
