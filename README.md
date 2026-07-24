# Szakyops v1.1.0
### An integrated system for system monitoring and automated backups

<img width="936" height="641" alt="image" src="https://github.com/user-attachments/assets/f0963a2d-e4b0-4723-8e09-1af146db80a2" />

Thank you for visiting the project page or downloading Szakyops!

Szakyops is a lightweight, resource-efficient toolset designed for Linux servers. It features **szakyfetch**, a minimal system monitoring module built entirely on native Linux commands, and **szakysave**, an automated, incremental backup utility that securely transfers your data to another machine using `rsync` and `ssh`. 

To provide a complete, hands-off administration experience, these two main tools are supported by three utility modules:
* **szakysetup:** An interactive wizard to easily configure your backup sources and targets.
* **szakycron:** An automation manager to schedule monitor reports and backups via crontab.
* **szakylog:** An interactive log viewer that allows you to inspect and export system logs with smart filtering.

## Project History

This toolkit originally started as a research project for a TDK (Scientific Students' Association) conference. In its earliest stages, the toolset consisted of two entirely separate, very simple standalone programs, each managed by its own independent and manually configured crontab entries.

With version `v1.0.0`, Szakyops has evolved into a fully integrated, unified management suite. The individual components have been redesigned into a sleek, modular architecture, now controlled through a centralized interface with automated cron handling and comprehensive logging.

For more information about the original project (written in Hungarian), please visit my website: https://szakysoft.hu/docs/Otthonserver.pdf

---

## Prerequisites

Before running the installer, ensure that your system has the required utilities installed.
The following **dependencies** MUST be installed:
* **curl** - to easily install the program remotely (or to clone the repository).
* **smartmontools** - to monitor the health and temperature of your hard drives.
* **rsync** - to perform efficient, incremental backups.

```bash
sudo apt update && sudo apt install curl smartmontools rsync
```

The following **recommended** dependencies add full functionality to the toolset:
* **lvm2** - to monitor LVM storage pools and logical volumes on your server.
* **wakeonlan** - to wake up your backup server before starting the backup process.

```bash
sudo apt update && sudo apt install lvm2 wakeonlan
```

## Installation

### Option 1: Quick Remote Installation
You can install Szakyops directly from GitHub using the following command:

```bash
curl -sSL https://raw.githubusercontent.com/CAKCEPBE3ET/szakyops/main/install.sh | sudo bash
```

### Option 2: Local Installation (Git Clone)
If you prefer to clone the repository locally, navigate to the project root and run the installer via the main executable:

```bash
git clone https://github.com/CAKCEPBE3ET/szakyops.git
cd Szakyops
sudo ./szakyops --install
```

Once installed, you can launch the program from anywhere in your terminal by running:

```bash
sudo szakyops
```

## Usage

It is highly recommended to execute the command with `sudo` to ensure proper access to hardware monitoring (SMART data, LVM) and backup automation.

After execution, you will be greeted by an interactive, terminal-based menu where you can manage system statistics, configure backup paths, view logs, and handle automated cron jobs with ease.

### Available CLI Flags
* `szakyops --fetch` – Runs the system statistics collection immediately.
* `szakyops --install` – Triggers the installation process.
* `szakyops --uninstall` – Completely removes Szakyops from your system.
* `szakyops --help` or `-h` – Displays the help message.

---

## The program

In this section, you will learn about the capabilities of the program from module to module.

### 1. Szakyfetch 
 
In this module, you can get information about the actual state of the computer. In the current version, the following aspects and specifications are shown:

**Header**
- Exact date of the report

**System**
- Operating System
- Hostname & Kernel
- System Uptime
- Load Average — the average load over the past 1, 5, and 15 minutes
- APT updates
- Network (interface name)

**Security & System**
- System Health — `SysErr` means systemd errors, `zombie` means the number of zombie processes
- Backup Status

**CPU & RAM**
- CPU name
- CPU Status — usage and temperature
- RAM — free memory in percentage and MB
- Top Consumers — top resource-consuming process for both CPU and RAM

**Storage**
- Name of the HDD/SSD
- Logical name of the HDD/SSD
- Temperature
- Pending and reallocated sectors
- Runtime — hours and cycles

**Volume Groups**
- Remaining free space and total space

**Mountpoints**
- All mountpoints, using `df -h`
- Usage and remaining space per mountpoint

**RAID & Containers**
- RAID — state and degradation
- Docker containers — state and number of running containers (stopped containers are also shown in the report)

### 2. Szakysetup 
This module is responsible for configuring the parameters used by szakysave. It creates a config 
directory inside `/opt/szakyops/` and generates a `szakyops.conf` file to securely store your target variables, network settings, and backup preferences.

### 3. Szakysave 
Szakysave is the core backup utility that securely transfers your data to a remote machine using rsync 
over SSH*. It performs efficient, incremental backups to save time and bandwidth. The module automatically 
verifies target network availability before initiating the file 
transfer, utilizes Wake-on-LAN (WOL) to wake up remote servers if needed, and seamlessly supports both Linux 
and Windows target environments.

#### What's new in v1.1.0:
- **Cold Backup support**: Detects running Docker database containers and native database services (`mysql`, `postgresql`, `mariadb`, `redis`, `mongo`) and gracefully stops them before the transfer to guarantee data consistency, automatically restarting them afterward via signal traps (`EXIT`, `INT`, `TERM`).
- **Fail-Safe Target Cleanup**: Automatically removes partial or interrupted backup directories from the destination machine (Windows & Linux compatible) if the process is cancelled (`Ctrl+C`) or fails.
- **Process Locking (`flock`)**: Uses a system lock (`/tmp/szakyops.lock`) to prevent concurrent or overlapping backup sessions.
- **Flexible WOL Execution**: Added a third power management option allowing WOL target wake-up without triggering an automated shutdown after completion.

*: If you configure a **Windows host** as your backup destination (`IS_WINDOWS="true"`), please ensure that:
1. **OpenSSH Server** is installed and running on the Windows machine.
2. **Git for Windows** is installed, and Git Bash is set as the default SSH shell on Windows, so the 
script can natively match standard POSIX utilities like `mkdir`, `find`, and `rsync`.

### 4. Szakycron 
Szakycron is the automation manager that handles the scheduling of your monitoring and 
backup tasks. It provides a simple, interactive interface to set up automated intervals for 
reports, schedule unattended backup routines directly into your system's crontab, and route the 
outputs of these tasks into properly organized log files.

### 5. Szakylog 
Szakylog is an interactive log viewer designed to help you easily monitor the 
outputs generated by your cron jobs. It allows you to read the latest monitoring 
and backup logs directly within the terminal, apply smart filtering to quickly identify 
system errors or failed transfers, and export log files for external analysis or long-term archiving.

---

## Disclaimer & License

Szakyops is an open-source project. The source code is fully transparent, and you are highly encouraged to review the scripts before installation to ensure they meet your security standards. 

This software is provided "as is", without warranty of any kind. While every effort has been made to ensure the toolset is safe and reliable, the author takes no responsibility for any potential data loss, system configuration issues, or damages resulting from the use of this program. Always verify your source and target paths before scheduling automated backups in a production environment.

Distributed under the MIT License. See `LICENSE` for more information.

---

If you get into any trouble, would like to express your opinion, or have an idea, you are welcome to contact me:

**Website:** www.szakysoft.hu
**Email:** info@szakysoft.hu
