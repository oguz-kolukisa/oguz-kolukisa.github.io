# oguz-kolukisa.github.io

A collection of automated installation scripts for quickly setting up development environments.

Scripts use **wget** (more commonly available on minimal systems) rather than curl.

## Quick Start

### Full Installation

Install all components with a single command:
```bash
wget -qO- https://oguz-kolukisa.github.io/install.sh | bash
```

For automatic "yes" to all prompts:
```bash
wget -qO- https://oguz-kolukisa.github.io/install.sh | bash -s -- -y
```

> **Note:** Piping a script from the web runs it without review. To inspect first: `wget -qO- https://oguz-kolukisa.github.io/install.sh -O install.sh && less install.sh && bash install.sh`

### Individual Components

Install only what you need:

#### Basic Tools
```bash
wget -qO- https://oguz-kolukisa.github.io/install/basic | bash
```
Installs: `curl`, `vim`, `git`, `cmake`, `pkg-config`, `net-tools`, `openssh-client`, `nmap`, `telnet`, `zip`, `unzip`, `unrar`, `htop`, `tmux`, `sysstat`, `lsd`

#### GitHub CLI
```bash
wget -qO- https://oguz-kolukisa.github.io/install/github | bash
```
Installs and authenticates GitHub CLI (`gh`)

#### Visual Studio Code
```bash
wget -qO- https://oguz-kolukisa.github.io/install/code | bash
```
Installs VS Code on Linux systems

#### Anaconda Python
```bash
wget -qO- https://oguz-kolukisa.github.io/install/anaconda | bash
```
  Installs Anaconda3 Python distribution

#### AI Coding Assistants (`install/ai/`)

- **Cursor agent CLI**
  ```bash
  wget -qO- https://oguz-kolukisa.github.io/install/ai/cursor | bash
  ```
  Installs Cursor agent CLI (npm @cursor/cli) for terminal; not the full Cursor IDE

- **Claude Code**
  ```bash
  wget -qO- https://oguz-kolukisa.github.io/install/ai/claude | bash
  ```
  Installs Claude Code AI coding assistant

- **GitHub Copilot CLI** (requires GitHub CLI)
  ```bash
  wget -qO- https://oguz-kolukisa.github.io/install/ai/copilot | bash
  ```
  Installs GitHub Copilot CLI

## Configuration

Configurations are written to `~/.config/oguz-setup/shell-config.sh` and sourced from `~/.bashrc` for easier reading and editing.

### All configurations (recommended)
```bash
wget -qO- https://oguz-kolukisa.github.io/install/config | bash
```
Installs LSD, Tuxsay, and Sudo users config; creates shared shell config file and sources it from bashrc.

### LSD Aliases Config
```bash
wget -qO- https://oguz-kolukisa.github.io/config/lsd | bash
```
Configures `lsd` aliases: `ls` → `lsd`, `ll` → `lsd -l`, `lt` → `lsd --tree` (supports `-d`/`--depth` and directory arguments)

### Tuxsay Terminal Config
```bash
wget -qO- https://oguz-kolukisa.github.io/config/tuxsay | bash
```
Configures a fun tuxsay greeting in your terminal

### Sudo users / groups
```bash
wget -qO- https://oguz-kolukisa.github.io/config/sudo-users | bash
```
Adds a list of users to a list of groups (e.g. `user1 user2 user3` → groups `sudo` and `docker`). Prompts for users and groups, or use env: `SUDO_USERS="u1 u2" SUDO_GROUPS="sudo docker" wget -qO- ... | bash`

## Help

Show all available commands:
```bash
wget -qO- https://oguz-kolukisa.github.io/help | bash
```

## Features

- **One-line installation**: Quick setup with a single wget command
- **Modular**: Install only what you need
- **Interactive**: Prompts for confirmation (use `-y` flag for automation)
- **Safe**: Checks for existing installations before proceeding
- **Clean**: Properly manages temporary files and GPG keys

## Requirements

- Ubuntu/Debian-based Linux distribution
- `wget` installed (or curl; scripts prefer wget)
- `sudo` privileges for system-level installations

## Project Structure

```
.
├── install.sh                 # Main installation script (calls install/config at end)
├── install/                    # Individual component installers
│   ├── basic                   # Basic tools installer
│   ├── github                  # GitHub CLI installer
│   ├── code                    # VS Code installer
│   ├── anaconda                # Anaconda installer
│   ├── config                  # All configurations (LSD, Tuxsay, Sudo users)
│   └── ai/                     # AI Coding Assistants
│       ├── cursor              # Cursor agent CLI installer
│       ├── claude              # Claude Code installer
│       └── copilot             # Copilot CLI installer
├── scripts/
│   ├── install_scripts/
│   │   ├── basic.sh, github.sh, code.sh, anaconda.sh
│   │   └── ai/
│   │       ├── cursor.sh, claude.sh, copilot.sh
│   └── config_settings/
│       ├── install_all_configs.sh   # Master config (shell-config.sh, bashrc source)
│       ├── lsd.sh, tuxsay.sh, sudo_users.sh
├── config/                     # Individual configuration scripts
│   ├── lsd                     # LSD aliases
│   ├── tuxsay                  # Tuxsay terminal
│   └── sudo-users              # Add users to groups (e.g. sudo, docker)
└── help                        # Help information
```

## Contributing

Feel free to submit issues or pull requests to improve these scripts.

## License

MIT License - Feel free to use and modify as needed.
