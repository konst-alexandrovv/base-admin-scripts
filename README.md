# System Administration Scripts / Скрипты системного администрирования

A collection of bash scripts for common system administration tasks, including system monitoring, backups, and maintenance.

Набор bash-скриптов для типовых задач системного администрирования, включая мониторинг системы, резервное копирование и обслуживание.

## Installation / Установка

```bash
git clone https://github.com/konst-alexandrovv/base-admin-scripts.git
cd base-admin-scripts/
./install.sh
```

The scripts will be installed to `./system-utils/scripts/` directory.

Скрипты будут установлены в директорию `./system-utils/scripts/`.

## Available Scripts / Доступные скрипты

### 1. System Monitor / Системный монитор
Displays real-time system resource usage.
Отображает использование системных ресурсов в реальном времени.

```bash
./monitor-system.sh
```

**Output / Вывод:**
- CPU usage / Использование процессора
- Memory usage / Использование памяти
- Disk usage / Использование диска

### 2. Backup Files / Резервное копирование
Creates dated backups of specified directories.
Создает датированные резервные копии указанных директорий.

```bash
./backup-files.sh <source_directory> <backup_directory>
```

### 3. Clean Logs / Очистка логов
Removes old log files based on specified age.
Удаляет старые лог-файлы на основе указанного возраста.

```bash
./clean-logs.sh <log_directory> <days>
```

### 4. Watch Directory / Мониторинг директории
Monitors directory for changes in real-time.
Отслеживает изменения в директории в реальном времени.

```bash
./watch-directory.sh <directory>
```

### 5. Find Duplicates / Поиск дубликатов
Identifies duplicate files in specified directory.
Находит дубликаты файлов в указанной директории.

```bash
./find-duplicates.sh <directory>
```

### 6. Network Monitor / Мониторинг сети
Displays active network connections and traffic.
Отображает активные сетевые соединения и трафик.

```bash
./network-monitor.sh
```

### 7. Disk Usage Alert / Оповещение о диске
Monitors disk usage and alerts when threshold is exceeded.
Отслеживает использование диска и оповещает при превышении порога.

```bash
./disk-usage-alert.sh <threshold_percentage>
```

## Requirements / Требования

- Bash 4.0+
- inotify-tools (for watch-directory.sh / для watch-directory.sh)
- iftop (for network-monitor.sh / для network-monitor.sh)
- Standard GNU utilities / Стандартные утилиты GNU

Review with Claude 3.5
