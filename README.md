# oguz-kolukisa.github.io

A collection of automated installation scripts for quickly setting up development environments.

## Quick Start

### Full Installation

Install all components with a single command:
```bash
curl -sSL https://oguz-kolukisa.github.io/install.sh | bash
```

For automatic "yes" to all prompts:
```bash
curl -sSL https://oguz-kolukisa.github.io/install.sh | bash -s -- -y
```

### Individual Components

Install only what you need:

#### Basic Tools
```bash
curl -sSL https://oguz-kolukisa.github.io/install/basic | bash
```
Installs: `curl`, `vim`, `git`, `cmake`, `pkg-config`, `net-tools`, `openssh-client`, `nmap`, `telnet`, `zip`, `unzip`, `unrar`, `htop`, `tmux`, `sysstat`

#### GitHub CLI
```bash
curl -sSL https://oguz-kolukisa.github.io/install/github | bash
```
Installs and authenticates GitHub CLI (`gh`)

#### GitHub Copilot CLI
```bash
curl -sSL https://oguz-kolukisa.github.io/install/copilot | bash
```
Installs GitHub Copilot CLI (requires GitHub CLI)

#### Visual Studio Code
```bash
curl -sSL https://oguz-kolukisa.github.io/install/code | bash
```
Installs VS Code on Linux systems

#### Anaconda Python
```bash
curl -sSL https://oguz-kolukisa.github.io/install/anaconda | bash
```
Installs Anaconda3 Python distribution

## Configuration

### Tuxsay Terminal Config
```bash
curl -sSL https://oguz-kolukisa.github.io/config/tuxsay | bash
```
Configures a fun tuxsay greeting in your terminal

## Help

Show all available commands:
```bash
curl -sSL https://oguz-kolukisa.github.io/help | bash
```

## Features

- **One-line installation**: Quick setup with a single curl command
- **Modular**: Install only what you need
- **Interactive**: Prompts for confirmation (use `-y` flag for automation)
- **Safe**: Checks for existing installations before proceeding
- **Clean**: Properly manages temporary files and GPG keys

## Requirements

- Ubuntu/Debian-based Linux distribution
- `curl` or `wget` installed
- `sudo` privileges for system-level installations

## Project Structure

```
.
├── install.sh                 # Main installation script
├── install/                   # Individual component installers
│   ├── basic                 # Basic tools installer
│   ├── github                # GitHub CLI installer
│   ├── copilot               # Copilot CLI installer
│   ├── code                  # VS Code installer
│   └── anaconda              # Anaconda installer
├── scripts/                  # Actual installation scripts
│   ├── install_scripts/
│   │   ├── basic.sh
│   │   ├── github.sh
│   │   ├── copilot.sh
│   │   ├── code.sh
│   │   └── anaconda.sh
│   └── config_settings/
│       └── tuxsay.sh
├── config/                   # Configuration scripts
│   └── tuxsay               # Tuxsay configuration
└── help                      # Help information
```

## Contributing

Feel free to submit issues or pull requests to improve these scripts.

## License

MIT License - Feel free to use and modify as needed.
