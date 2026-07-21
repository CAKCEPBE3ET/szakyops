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

