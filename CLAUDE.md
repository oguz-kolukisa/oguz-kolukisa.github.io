# CLAUDE.md

This file provides guidance for AI assistants working on this repository.

## Project Overview

This is a **GitHub Pages static website** that serves as a distribution hub for automated Linux development environment setup scripts. The site presents a retro terminal-themed UI and provides wget-based one-liner commands to install tools and configure shell environments on Ubuntu/Debian systems.

**Live site:** `https://oguz-kolukisa.github.io`

## Repository Structure

```
oguz-kolukisa.github.io/
├── index.html                          # Main website (interactive terminal UI)
├── 404.html                            # Custom 404 error page
├── install.sh                          # Master installer (orchestrates all components)
├── help                                # Help text script (bash, no .sh extension)
├── robots.txt
├── sitemap.xml
├── og-image.png
│
├── install/                            # Public entry points (web-accessible wrappers)
│   ├── basic                           # Installs basic CLI tools
│   ├── github                          # Installs GitHub CLI
│   ├── code                            # Installs VS Code
│   ├── anaconda                        # Installs Anaconda Python
│   ├── config                          # Applies all shell configurations
│   └── ai/
│       ├── claude                      # Installs Claude Code
│       ├── cursor                      # Installs Cursor agent CLI
│       └── copilot                     # Installs GitHub Copilot CLI
│
├── config/                             # Individual config entry points
│   ├── lsd                             # LSD aliases config
│   ├── tuxsay                          # Tuxsay terminal greeting config
│   └── grpadd                          # grpadd shell function config
│
├── scripts/                            # Implementation scripts (not public entry points)
│   ├── install_scripts/
│   │   ├── basic.sh
│   │   ├── github.sh
│   │   ├── code.sh
│   │   ├── anaconda.sh
│   │   └── ai/
│   │       ├── claude.sh
│   │       ├── cursor.sh
│   │       └── copilot.sh
│   └── config_settings/
│       ├── install_all_configs.sh      # Master config orchestrator
│       ├── lsd.sh
│       ├── tuxsay.sh
│       └── sudo_users.sh              # grpadd function
│
└── sounds/                             # Audio assets directory (files not committed)
    └── README.md                       # Documents required audio file names/specs
```

## Architecture: Two-Layer Wrapper Pattern

All installer endpoints follow a consistent two-layer pattern:

```
User wget command
    ↓
/install/<tool>          ← Public entry point (thin wrapper)
    ↓ downloads
/scripts/install_scripts/<tool>.sh  ← Implementation (actual logic)
    ↓ executes
apt-get / external installer
```

**Entry point files** (in `install/` and `config/`) are thin wrappers that:
1. Download the implementation script to a temp file via wget
2. Validate the download succeeded (`[ ! -s "$TEMP_SCRIPT" ]` check)
3. Execute it and clean up

**Implementation scripts** (in `scripts/`) contain the actual installation logic.

## Technology Stack

- **Frontend:** Vanilla HTML5/CSS3/JavaScript (no frameworks, no build tools)
- **Scripting:** Bash shell scripts
- **Package manager:** APT (Ubuntu/Debian-based systems only)
- **HTTP tool:** `wget` (preferred over curl for portability on minimal systems)
- **Hosting:** GitHub Pages (files served as-is, no build pipeline)

## Shell Script Conventions

All bash scripts must follow these patterns:

### Required header
```bash
#!/bin/bash
set -euo pipefail
```

### Download validation
Always verify downloaded files are non-empty before executing:
```bash
TEMP_SCRIPT=$(mktemp)
wget -q "$BASE_URL/path/to/script.sh" -O "$TEMP_SCRIPT"
if [ ! -s "$TEMP_SCRIPT" ]; then
  printf "Error: Failed to download script.\n" >&2
  rm -f "$TEMP_SCRIPT"
  exit 1
fi
```

### Temp file cleanup
Use `trap` for guaranteed cleanup:
```bash
TEMP_DIR=$(mktemp -d)
trap 'rm -rf "$TEMP_DIR"' EXIT
```

### User prompts
Read from `/dev/tty` explicitly (scripts may be piped from stdin):
```bash
read -p "Do you want to install X? (y/n): " answer </dev/tty
```

### Output
Use `printf` instead of `echo` for consistent behavior:
```bash
printf "Installing X...\n"
printf "================================\n"
printf "X installed successfully!\n"
printf "================================\n"
```

### Conditional installation check
Verify installation success after running:
```bash
if ! command -v git &>/dev/null; then
  printf "Warning: git installation may have failed.\n" >&2
fi
```

## Shell Configuration System

Configurations are managed via a shared config file, not directly in `~/.bashrc`:

- **Config file location:** `~/.config/oguz-setup/shell-config.sh`
- **Sourced from:** `~/.bashrc` (one line added: `[ -f "~/.config/oguz-setup/shell-config.sh" ] && . "~/.config/oguz-setup/shell-config.sh"`)
- **`OGUZ_SHELL_CONFIG` env var:** Exported by `install_all_configs.sh` so all sub-scripts know where to write config without hardcoding the path
- **Section markers:** Config blocks use delimiters for idempotent updates. Two valid forms exist:
  ```
  # ========== SECTION NAME START ==========
  ...config content...
  # ========== END ==========
  ```
  or (legacy/named end):
  ```
  # ========== SECTION NAME START ==========
  ...config content...
  # ========== SECTION NAME END ==========
  ```

The `install_all_configs.sh` script handles:
- Creating the config directory/file
- Adding the source line to `~/.bashrc` (once, idempotently)
- **Migrating legacy config** — actively removes old `LSD`, `TUXSAY`, `PENGUIN`, and local bin PATH blocks from `~/.bashrc` if present, moving them to `shell-config.sh`
- Adding `$HOME/.local/bin` to `PATH` in `shell-config.sh` (under `# ========== OGUZ LOCAL BIN PATH ==========` marker)
- Exporting `OGUZ_SHELL_CONFIG` so sub-scripts write to the right file

## install.sh Flags

The master installer supports a `-y` flag for non-interactive use (auto-yes to all prompts):

```bash
wget -qO- https://oguz-kolukisa.github.io/install.sh | bash -s -- -y
```

When `-y` is set, all `read` prompts are skipped and every component is installed automatically.

## Adding a New Config

To add a new shell configuration (e.g., `myalias`):

1. **Create the implementation script** at `scripts/config_settings/myalias.sh`:
   ```bash
   #!/bin/bash
   set -euo pipefail
   CONFIG_FILE="${OGUZ_SHELL_CONFIG:-$HOME/.config/oguz-setup/shell-config.sh}"
   MARKER="# ========== MYALIAS CONFIG START =========="
   if grep -qF "$MARKER" "$CONFIG_FILE" 2>/dev/null; then
     printf "myalias config already present. Skipping.\n"
     exit 0
   fi
   printf "Adding myalias config...\n"
   cat >> "$CONFIG_FILE" <<'EOF'
   # ========== MYALIAS CONFIG START ==========
   alias myalias='echo hello'
   # ========== END ==========
   EOF
   printf "myalias config added.\n"
   ```

2. **Create the entry point** at `config/myalias` (no extension):
   ```bash
   #!/bin/bash
   set -euo pipefail
   BASE_URL="https://oguz-kolukisa.github.io"
   TEMP_SCRIPT=$(mktemp)
   wget -q "$BASE_URL/scripts/config_settings/myalias.sh" -O "$TEMP_SCRIPT"
   if [ ! -s "$TEMP_SCRIPT" ]; then
     printf "Error: Failed to download script.\n" >&2
     rm -f "$TEMP_SCRIPT"
     exit 1
   fi
   chmod +x "$TEMP_SCRIPT"
   bash "$TEMP_SCRIPT"
   rm -f "$TEMP_SCRIPT"
   printf "================================\n"
   printf "myalias config complete!\n"
   printf "================================\n"
   ```

3. **Add it to `scripts/config_settings/install_all_configs.sh`** — download and run in the config block.

4. **Update `index.html`** and **`README.md`** to document the new config command.

## Adding a New Installer

To add a new tool (e.g., `neovim`):

1. **Create the implementation script** at `scripts/install_scripts/neovim.sh`:
   ```bash
   #!/bin/bash
   set -euo pipefail
   printf "Installing neovim...\n"
   sudo apt-get update -qq
   sudo apt-get install -y neovim
   printf "neovim installed successfully!\n"
   ```

2. **Create the entry point** at `install/neovim`:
   ```bash
   #!/bin/bash
   set -euo pipefail
   BASE_URL="https://oguz-kolukisa.github.io"
   TEMP_SCRIPT=$(mktemp)
   wget -q "$BASE_URL/scripts/install_scripts/neovim.sh" -O "$TEMP_SCRIPT"
   if [ ! -s "$TEMP_SCRIPT" ]; then
     printf "Error: Failed to download script.\n" >&2
     rm -f "$TEMP_SCRIPT"
     exit 1
   fi
   chmod +x "$TEMP_SCRIPT"
   bash "$TEMP_SCRIPT"
   rm -f "$TEMP_SCRIPT"
   printf "================================\n"
   printf "neovim installation complete!\n"
   printf "================================\n"
   ```

3. **Update `install.sh`** to include a prompt and call for the new installer.

4. **Update `index.html`** to add the command to the terminal UI.

5. **Update `README.md`** to document the new command.

## Frontend (index.html)

The website is a single 2000+ line HTML file with embedded CSS and JavaScript. Key features:

- **Terminal emulator interface** with command input
- **CRT/scanline visual effects** with retro green-on-black theme (`#00ff41`)
- **Matrix rain animation** on canvas background
- **Dark theme toggle**
- **Audio framework** (mute button; requires audio files in `sounds/` that are not committed)
- **Man page viewer** (ESC to close)
- **Copy-to-clipboard** buttons for install commands

When editing `index.html`:
- All CSS and JavaScript are embedded — there are no separate asset files
- Keep the retro terminal aesthetic consistent
- Sound effects reference `sounds/keypress.mp3`, `sounds/click.mp3`, `sounds/hover.mp3` — these are documented in `sounds/README.md` but not committed

## Deployment

**No build process.** The repository IS the deployment:
- Every git push to `main`/`master` is automatically published via GitHub Pages
- Files are served directly as-is — HTML, shell scripts, and all
- Shell scripts have no extensions in `install/` and `config/` — this is intentional so they can be piped directly to bash

## Key URLs

| File in repo | Served at |
|---|---|
| `install/basic` | `https://oguz-kolukisa.github.io/install/basic` |
| `scripts/install_scripts/basic.sh` | `https://oguz-kolukisa.github.io/scripts/install_scripts/basic.sh` |
| `install.sh` | `https://oguz-kolukisa.github.io/install.sh` |
| `index.html` | `https://oguz-kolukisa.github.io/` |

## What NOT to Do

- **Do not add a build system** (no npm, webpack, Jekyll, etc.) — the simplicity is intentional
- **Do not use curl** in scripts — wget is used for portability on minimal Ubuntu installs
- **Do not write config directly to `~/.bashrc`** — all config goes through `~/.config/oguz-setup/shell-config.sh`
- **Do not add file extensions** to scripts in `install/` or `config/` — they are served and piped directly to bash
- **Do not use `echo`** for output in scripts — use `printf` for consistent cross-platform behavior
- **Do not skip the `[ ! -s "$TEMP_SCRIPT" ]` validation** in entry point wrappers

## Clean Code Standards (Uncle Bob)

This project follows Robert C. Martin's Clean Code principles. **After every code change, verify the code adheres to these standards. If it does not, refactor until it does.**

### Functions
- **Small**: Each function/script should do one thing only. Keep functions short and focused.
- **One level of abstraction**: Don't mix high-level orchestration with low-level details in the same function.
- **Minimal arguments**: Prefer fewer parameters. Use well-named variables instead of positional magic.
- **No side effects**: Functions should do what their name says and nothing else.
- **Command-Query Separation**: A function either performs an action or returns data, not both.

### Naming
- **Intention-revealing names**: Variable and function names must clearly describe their purpose (`TEMP_SCRIPT`, `CONFIG_FILE`, `_dl`, `install_basics` — not `x`, `tmp`, `f`).
- **No abbreviations**: Avoid cryptic short names. `SEPARATOR_START` is better than `SEP_S`.
- **Consistent vocabulary**: Use the same word for the same concept everywhere (e.g., always `TEMP_SCRIPT` for temporary downloaded scripts, always `TARGET` for the config write destination).

### DRY (Don't Repeat Yourself)
- **Extract repeated patterns into functions**: If 3+ scripts share the same boilerplate, extract it into a reusable function.
- **Entry point wrappers** use a shared `download_and_run` function pattern — do not duplicate download/validate/execute/cleanup logic across files.
- **Prompt-and-install blocks** in `install.sh` use the `prompt_and_run` helper — do not repeat the if/else AUTO_YES pattern inline.
- **Download-and-validate blocks** in `install_all_configs.sh` use the `_dl_config` helper — do not repeat wget/validate for each config script.

### Consistency
- **Always use `trap` for cleanup** — never use manual `rm -f` after execution. Trap guarantees cleanup even on errors.
- **Always use `printf`** — never use `echo` for output (cross-platform consistency).
- **Always use `set -euo pipefail`** — every script starts with this.
- **Always validate downloads** — `[ ! -s "$TEMP_SCRIPT" ]` check after every wget.
- **Consistent error format** — all errors use `printf "Error: ...\n" >&2`.
- **Consistent grep flags** — use `grep -qF` for fixed-string matching, `grep -q` for regex.

### Constants Over Magic Values
- **Extract version numbers** into named constants at the top of the script (e.g., `ANACONDA_VERSION`, `NVM_FALLBACK_VERSION`).
- **Use `BASE_URL` variable** — never hardcode the site URL inline.

### Boy Scout Rule
- Leave every file cleaner than you found it. When touching a file, fix any nearby violations of these standards.

### Post-Write Checklist
After writing or modifying any code, verify:
1. No duplicated boilerplate (DRY)
2. Functions do one thing (SRP)
3. Names reveal intent
4. No `echo` usage (use `printf`)
5. Cleanup uses `trap`, not manual `rm`
6. No magic values — constants are named
7. Consistent patterns across similar files
8. `set -euo pipefail` header present
9. Download validation present for all wget calls

## Requirements

Target environment for all scripts:
- Ubuntu/Debian-based Linux (APT package manager)
- `wget` available
- `sudo` privileges
