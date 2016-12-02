memusage() { ps aux | grep -i $1  | grep -v grep | awk '{ sum += $6} END { printf "%0.2f GB\n", sum/1048576 }'; }
