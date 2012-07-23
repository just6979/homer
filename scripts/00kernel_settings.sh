#!/system/bin/sh

# Read-ahead
echo 1024 > /sys/devices/virtual/bdi/179:0/read_ahead_kb

# Clock Speed
echo 100000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo 1000000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq

# Governor
echo interactive > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

# BLD
echo 1 > /sys/class/misc/backlightdimmer/enabled
echo 6000 > /sys/class/misc/backlightdimmer/delay
