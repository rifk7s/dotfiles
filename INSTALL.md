# Developer Environment Setup

This document serves as a reference for setting up specific development environments that are not fully covered by the automated `install.sh` dotfiles orchestration.

## Laravel Setup Architecture

The local PHP development stack is composed of legitimate, lightweight native macOS applications to replace heavy virtualization:

```text
Herd ─── PHP 8.4 / 8.5
     ├── Composer
     ├── Laravel installer
     ├── NVM (Node.js v22)
     ├── Nginx (auto-configured)
     └── phpMyAdmin → http://phpmyadmin.test

DBngin ─── MySQL server (local instances)
        └── socket at /tmp/mysql_<PORT>.sock

mysql-client (Brew) ─── CLI access to DBngin
```

### Setup Steps

1. **Install [Herd](https://herd.laravel.com)** (via `Brewfile`) - manages PHP, Composer, Laravel installer, NVM, and Nginx.
2. **Install [DBngin](https://dbngin.com)** (via `Brewfile`) - GUI for running local MySQL server instances.
3. **Install mysql-client** (via `Brewfile`) - CLI-only client.
   > **Note:** Do NOT install the full `mysql` formula (server+client) via Homebrew, as it conflicts with DBngin.
4. **.zshrc Configuration** (already synced):
   ```bash
   export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

   # Connect to DBngin MySQL by port (e.g. mysqls 3306)
   function mysqls() {
       command mysql --socket /tmp/mysql_$1.sock -u root
   }
   ```
5. **phpMyAdmin** - add as a Herd site, accessible at `http://phpmyadmin.test`.
6. **TablePlus** (via `Brewfile`) - Native GUI database client.

### Connecting to MySQL

```bash
# Via shortcut function (port 3306)
mysqls 3306

# Via full command
mysql -u root -S /tmp/mysql_3306.sock

# Connect to specific database
mysql -u root -S /tmp/mysql_3306.sock mydb
```

---

> **Note on Application Tracking:**
> The old giant list of manual downloads, App Store apps, and excluded/cracked apps (Adobe, Microsoft, etc.) has been migrated to `setup/manual_apps.sh`. Run `./install.sh` to trigger the Smart Auditor instead.
