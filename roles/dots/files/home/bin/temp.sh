echo "$(sensors | grep Core | awk '{s+=$3} END {printf "%.2f\n", s / 6}' | sed s/+// | sed s/°C//)󰔄 $(asusctl profile -p | grep Active | awk '{ print $4 }')"
