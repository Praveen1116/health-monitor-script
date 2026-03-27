# Health Monitor Script

Health Monitor Script is a lightweight Bash utility I built to continuously check the health of important **systemd** services on a Linux machine.
It validates whether each service is running, automatically restarts anything that is down, logs the recovery result, and prints a clear summary at the end.

## What this project does

- Reads a list of services from `services.txt`
- Checks each service using `systemctl is-active`
- If a service is inactive, restarts it using `systemctl restart`
- Re-checks the service status after restart
- Logs recovery results to `/var/log/health_monitor.log`
- Prints a final summary:
  - Total services checked
  - Healthy services
  - Services recovered after restart
  - Services still failing

## Project structure

- `health_monitor.sh` — main script
- `services.txt` — service names to monitor (one per line)
- `screenshot.png` — sample output screenshot

## Requirements

- Linux with **systemd**
- `bash`
- `systemctl`
- `sudo` access (for restarting services and appending to `/var/log/health_monitor.log`)

## Setup

### 1) Clone the repository

```bash
git clone https://github.com/Praveen1116/health-monitor-script.git
cd health-monitor-script
```

### 2) Give execute permission

```bash
chmod +x health_monitor.sh
```

### 3) Add services to monitor

Edit `services.txt` and add the service names you want to check (one per line). Example:

```text
ssh
cron
nginx
fake-service
```

## Run

### Normal mode (checks + restarts failed services)

```bash
./health_monitor.sh
```

### Dry run mode (checks only, no restart)

```bash
./health_monitor.sh --dry-run
```

## Logging

The script writes recovery results to:

- **`/var/log/health_monitor.log`**

Log format includes timestamp and level:

- `YYYY-MM-DD HH:MM:SS [INFO] <service> RECOVERED`
- `YYYY-MM-DD HH:MM:SS [ERROR] <service> FAILED`

## Output

For each service, the script prints whether it is running or not.  
At the end, it prints:

- Total Checked
- Healthy
- Recovered
- Failed

## Screenshot

<img width="1920" height="1080" alt="screenshot" src="https://github.com/user-attachments/assets/92baf5ff-807c-4c72-9d44-89a972ae19fe" />
