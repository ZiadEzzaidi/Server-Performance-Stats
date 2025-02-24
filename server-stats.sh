# Get total CPU usage
cpu_usage=$(top -bn1 | grep "Cpu(s)" | \
           sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | \
           awk '{print 100 - $1"%"}')
echo "Total CPU Usage: $cpu_usage"

## top: Displays real-time system summary information.
## -b: Runs top in batch mode, which is useful for scripting.
## -n1: Limits the output to a single iteration.

## |: Pipes the output of the top command to the next command.
## grep "Cpu(s)": Searches for the line containing "Cpu(s)" which includes CPU usage information.

## sed: Stream editor for filtering and transforming text.
## s/.*, *\([0-9.]*\)%* id.*/\1/: This sed command uses a regular expression to extract the idle CPU percentage. It matches the pattern and captures the idle percentage in \1.

## awk: A programming language for pattern scanning and processing.
## {print 100 - $1"%"}: Subtracts the idle CPU percentage from 100 to get the used CPU percentage and appends a %` sign.

# Get total memory usage
memory_usage=$(free -m | awk 'NR==2{printf "Memory Usage: %s/%sMB (%.2f%%)\n", $3, $2, $3*100/$2 }')
echo "$memory_usage"

## free -m: Displays memory usage in megabytes.
## awk 'NR==2{...}': Processes the second line of the output (Number of Records) (which contains the memory usage information).
## printf "Memory Usage: %s/%sMB (%.2f%%)\n", $3, $2, $3*100/$2: Formats the output to show used memory, total memory, and the percentage of used memory.

# Get total disk usage
disk_usage=$(df -h --total | awk 'END{printf "Disk Usage: %s/%s (%s)\n", $3, $2, $5}')
echo "$disk_usage"

## df -h --total: Displays disk usage in a human-readable format and adds a total line at the end.
## awk 'END{...}': Processes the last line of the output (which contains the total disk usage information).
## printf "Disk Usage: %s/%s (%s)\n", $3, $2, $5: Formats the output to show used disk space, total disk space, and the percentage of used disk space.

# Get top 5 processes by CPU usage
echo "Top 5 processes by CPU usage:"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6

## ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu: Lists all processes with their PID, PPID, command, memory usage, and CPU usage, sorted by CPU usage in descending order.
## head -n 6: Limits the output to the top 6 lines (including the header).
## The -eo option in the ps command is used to specify the format of the output. Here's a breakdown:
## -e: Selects all processes.
## -o: Allows you to specify the output format.
## When combined, -eo lets you define which columns you want to display in the output.

# Get top 5 processes by memory usage
echo "Top 5 processes by memory usage:"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6

## (similar to the previous command, but sorts by memory usage instead of CPU usage)