# Changelog

All notable changes to the **Szakyops** project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [v1.0.1] - 2026-07-21

### Fixed
- **SSH Key Path Resolution:** Fixed issue where `$HOME` resolved to `/root` under `sudo` execution. Automatically detects `$SUDO_USER` home directory. 
- **Log Exporter Filter:** Fixed regex pattern matching for date searches to prevent false interval triggers when using hyphenated dates (e.g. `2026-07-20`).

### Added
- **New crontab option:** Backup every minute is now available for experimental purposes.

### Removed
- **Log exporter filter:** Removed `alert` and `warning` keyword filtering options from the exporter.
---

## [v1.0.2] - 2026-07-21

### Fixed
- **Backup for Windows:** The responsible branch for `szakysave's` backup for windows has been tested and fixed
---

## [v1.1.0] - 2026-07-24

### Fixed
- **Log Exporter Filter:** Fixed regex pattern for Backup Session Report matching in `szakylog`
- **Szakycron UX prompt:** Updated backup frequency selection prompt range from `[1-3]` to `[1-4]`
- **Uninstaller:** Improved deletion script which is able to delete crontab comments which were used by `szakycron`

### Added
- **Cold Backup support:** Automatically detects running Docker containers and native database services (`mysql`, `postgresql`, `mariadb`, `redis`, `mongo`) and safely stops them before transfer.
- **Auto-restart & Traps**: Ensures databases are always restarted on completion or unexpected interruption (`INT`, `TERM`, `EXIT`).
- **Target cleanup on failure**: Incomplete backup directories are automatically removed from the target machine (Windows & Linux compatible) if the rsync session fails or gets cancelled.
- **Process locking**: Prevents overlapping execution using `/tmp/szakyops.lock` via `flock`.

## [v1.1.1] - 2026-07-24 

### Fixed
- **Installer Data Loss:** Fixed `install.sh` accidentally deleting local cloned repositories during installation.
- **Uninstaller Cron Cleanup:** Fixed uninstaller regex to properly remove both fetch and `run_szakysave` cron jobs.
- **Cold Backup Non-Interactive Privileges:** Added non-interactive `sudo -n` fallbacks for Docker and systemd service checks and lifecycle commands (`start`/`stop`).
