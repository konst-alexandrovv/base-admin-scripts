#!/bin/bash

INSTALL_DIR=$(pwd)/system-utils

# Create installation message function
msg() {
    echo "$1"
    echo "$2"
    echo
}

# Create directory structure
create_structure() {
    mkdir -p $INSTALL_DIR/scripts
}

# Create utility scripts
create_scripts() {
    # System Monitor / Системный монитор
    cat > $INSTALL_DIR/scripts/monitor-system.sh << 'EOF'
#!/bin/bash
# System resources monitoring / Мониторинг системных ресурсов
monitor_system() {
    while true; do
        clear
        echo "=== System Monitor / Системный монитор ==="
        echo "CPU Usage / Использование CPU:"
        top -bn1 | grep "Cpu(s)" | awk '{print $2}'
        echo -e "\nMemory Usage / Использование памяти:"
        free -h
        echo -e "\nDisk Usage / Использование диска:"
        df -h /
        sleep 5
    done
}
monitor_system
EOF

    # Backup Files / Резервное копирование
    cat > $INSTALL_DIR/scripts/backup-files.sh << 'EOF'
#!/bin/bash
# Create dated backups / Создание резервных копий с датой
backup_directory() {
    local source_dir="$1"
    local backup_dir="$2"
    local date_stamp=$(date +%Y%m%d_%H%M%S)
    local backup_name="backup_${date_stamp}.tar.gz"

    if [ ! -d "$backup_dir" ]; then
        mkdir -p "$backup_dir"
    fi

    tar -czf "${backup_dir}/${backup_name}" "$source_dir"
    echo "Backup created / Резервная копия создана: ${backup_dir}/${backup_name}"
}
backup_directory "$1" "$2"
EOF

    # Clean Logs / Очистка логов
    cat > $INSTALL_DIR/scripts/clean-logs.sh << 'EOF'
#!/bin/bash
# Clean old log files / Очистка старых лог-файлов
clean_logs() {
    local log_dir="$1"
    local days_old="$2"

    find "$log_dir" -type f -name "*.log" -mtime +"$days_old" -exec rm {} \;
    echo "Removed log files older than / Удалены лог-файлы старше $days_old days from / дней из $log_dir"
}
clean_logs "$1" "$2"
EOF

    # Watch Directory / Мониторинг директории
    cat > $INSTALL_DIR/scripts/watch-directory.sh << 'EOF'
#!/bin/bash
# Monitor directory changes / Мониторинг изменений в директории
watch_directory() {
    local dir="$1"

    inotifywait -m -r -e create,modify,delete "$dir" | while read path action file; do
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] Action/Действие: $action Path/Путь: $path$file"
    done
}
watch_directory "$1"
EOF

    # Find Duplicates / Поиск дубликатов
    cat > $INSTALL_DIR/scripts/find-duplicates.sh << 'EOF'
#!/bin/bash
# Find duplicate files / Поиск дубликатов файлов
find_duplicates() {
    local dir="$1"
    echo "Finding duplicates in / Поиск дубликатов в: $dir"
    find "$dir" -type f -exec md5sum {} \; | sort | uniq -d -w32
}
find_duplicates "$1"
EOF

    # Network Monitor / Мониторинг сети
    cat > $INSTALL_DIR/scripts/network-monitor.sh << 'EOF'
#!/bin/bash
# Monitor network connections / Мониторинг сетевых соединений
monitor_network() {
    while true; do
        clear
        echo "=== Active Network Connections / Активные сетевые соединения ==="
        netstat -tuln
        echo -e "\n=== Current Traffic / Текущий трафик ==="
        iftop -N -n
        sleep 5
    done
}
monitor_network
EOF

    # Disk Usage Alert / Оповещение о диске
    cat > $INSTALL_DIR/scripts/disk-usage-alert.sh << 'EOF'
#!/bin/bash
# Disk usage monitoring / Оповещение о заполнении диска
check_disk_usage() {
    local threshold="$1"
    local usage=$(df / | tail -n 1 | awk '{print $5}' | sed 's/%//')

    if [ "$usage" -gt "$threshold" ]; then
        echo "WARNING / ВНИМАНИЕ: Disk usage exceeds / Использование диска превышает ${threshold}%"
        echo "Current usage / Текущее использование: ${usage}%"
    fi
}
check_disk_usage "$1"
EOF
}

# Make scripts executable
make_executable() {
    chmod +x $INSTALL_DIR/scripts/*.sh
}

# Create help file
create_help() {
    cat > $INSTALL_DIR/README.md << 'EOF'
# System Utilities / Системные утилиты

## Usage / Использование:

1. System Monitor / Системный монитор:
   ```bash
   ./monitor-system.sh
   ```

2. Backup / Резервное копирование:
   ```bash
   ./backup-files.sh source_dir backup_dir
   ```

3. Clean Logs / Очистка логов:
   ```bash
   ./clean-logs.sh /var/log 7
   ```

4. Watch Directory / Мониторинг директории:
   ```bash
   ./watch-directory.sh /path/to/watch
   ```

5. Find Duplicates / Поиск дубликатов:
   ```bash
   ./find-duplicates.sh /path/to/search
   ```

6. Network Monitor / Мониторинг сети:
   ```bash
   ./network-monitor.sh
   ```

7. Disk Alert / Оповещение о диске:
   ```bash
   ./disk-usage-alert.sh 90
   ```
EOF
}

# Main installation
install() {
    msg "Installing system utilities to $INSTALL_DIR" \
        "Установка системных утилит в $INSTALL_DIR"

    create_structure
    create_scripts
    make_executable
    create_help

    msg "Installation complete" \
        "Установка завершена"
    msg "See README.md for usage instructions" \
        "Смотрите README.md для инструкций по использованию"
}

install
