# 🛠️ Health Monitor Script (Linux)

A Bash script to monitor system services, attempt recovery, and log results with proper status tracking.

---

## 🚀 Features

- Reads services from `services.txt`
- Checks service status using `systemctl is-active`
- Automatically restarts stopped services
- Logs results with timestamp and severity to `/var/log/health_monitor.log`
- Shows summary: Total Checked / Healthy / Recovered / Failed
- Handles missing/empty `services.txt` gracefully
- Supports `--dry-run` mode (simulates without actual restart)

---

## 📂 Project Structure

bash_assignment_/
├── health_monitor.sh
├── services.txt
├── screenshot.png
└── README.md

    health_monitor.sh: Main monitoring script.

    services.txt: List of services to monitor (one per line).

    screenshot.png: Screenshot of script output.

    README.md: This documentation.

⚙️ Usage

    Make script executable:
    Bash

chmod +x health_monitor.sh

Run normally:
Bash

./health_monitor.sh

Run in dry-run mode (no actual restart):
Bash

    ./health_monitor.sh --dry-run

🖥️ Sample Output

Based on the execution:
Plaintext

ssh is NOT running
Failed to restart ssh.service: Unit ssh.service not found.
ssh failed
cron is running
nginx is NOT running
nginx recovered
fake-service is NOT running
Failed to restart fake-service.service: Unit fake-service.service not found.
fake-service failed
---------------------------
Total Checked : 4
Healthy       : 1
Recovered     : 1
Failed        : 2

📸 Screenshot
<img width="999" height="814" alt="Screenshot from 2026-03-27 12-49-11" src="https://github.com/user-attachments/assets/89d4eace-9504-464f-b1d4-c9eb229118cc" />


This screenshot shows the output of the script with correct user and host info.
🧠 Concepts Used

    Bash scripting: Used for automating the monitoring process.

    Systemctl commands: Utilized systemctl is-active for status checks and systemctl restart for recovery.

    Conditional logic: if/else statements to handle service states and dry-run flags.

    Loops: while loop to iterate through the service list.

    File handling: Reading from services.txt and appending to log files.

    Logging and timestamps: Using the date command to provide time-stamped log entries.

    Command-line flags: Implementation of the --dry-run argument.

👨‍💻 Author

Praveen Yadav
