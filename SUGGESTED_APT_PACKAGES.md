# Suggested APT Packages for Implementation

This document lists other basic apt packages that can be implemented in the install_scripts directory.

## Currently Implemented Packages

### basic.sh
- `curl` - Command-line tool for transferring data with URLs
- `vim` - Powerful text editor
- `git` - Version control system

### tuxsay.sh
- `fortune-mod` - Fortune cookie program
- `fortunes` - Fortune database
- `cowsay` - ASCII art cow that displays messages

## Suggested Basic Packages

### Development Tools
1. **build-essential**
   - Essential compilation tools (gcc, g++, make)
   - Required for building software from source
   - Usage: `sudo apt-get install -y build-essential`

2. **gdb**
   - GNU Debugger for debugging programs
   - Usage: `sudo apt-get install -y gdb`

3. **cmake**
   - Cross-platform build system generator
   - Usage: `sudo apt-get install -y cmake`

4. **pkg-config**
   - Helper tool for compiling applications and libraries
   - Usage: `sudo apt-get install -y pkg-config`

### Text Editors
5. **nano**
   - Simple, easy-to-use text editor
   - Usage: `sudo apt-get install -y nano`

6. **emacs**
   - Extensible, customizable text editor
   - Usage: `sudo apt-get install -y emacs`

### Network Tools
7. **wget**
   - Network downloader (alternative to curl)
   - Usage: `sudo apt-get install -y wget`

8. **net-tools**
   - Networking utilities (ifconfig, netstat, etc.)
   - Usage: `sudo apt-get install -y net-tools`

9. **openssh-server**
   - SSH server for remote access
   - Usage: `sudo apt-get install -y openssh-server`

10. **openssh-client**
    - SSH client (usually pre-installed)
    - Usage: `sudo apt-get install -y openssh-client`

11. **telnet**
    - Network protocol tool
    - Usage: `sudo apt-get install -y telnet`

12. **nmap**
    - Network exploration and security auditing tool
    - Usage: `sudo apt-get install -y nmap`

### File Management and Compression
13. **zip / unzip**
    - Archive and compression utilities
    - Usage: `sudo apt-get install -y zip unzip`

14. **tar**
    - Tape archiver (usually pre-installed)
    - Usage: `sudo apt-get install -y tar`

15. **p7zip-full**
    - 7-Zip compression tool
    - Usage: `sudo apt-get install -y p7zip-full`

16. **unrar**
    - RAR archive extraction tool (Note: 'rar' is proprietary and not in standard repos)
    - Usage: `sudo apt-get install -y unrar`

17. **tree**
    - Display directory tree structure
    - Usage: `sudo apt-get install -y tree`

### System Monitoring and Management
18. **htop**
    - Interactive process viewer (enhanced top)
    - Usage: `sudo apt-get install -y htop`

19. **tmux**
    - Terminal multiplexer
    - Usage: `sudo apt-get install -y tmux`

20. **screen**
    - Terminal multiplexer (alternative to tmux)
    - Usage: `sudo apt-get install -y screen`

21. **neofetch**
    - System information tool with ASCII art
    - Usage: `sudo apt-get install -y neofetch`

22. **lsof**
    - List open files
    - Usage: `sudo apt-get install -y lsof`

23. **sysstat**
    - System performance monitoring tools
    - Usage: `sudo apt-get install -y sysstat`

### Version Control and Collaboration
24. **git-lfs**
    - Git Large File Storage
    - Usage: `sudo apt-get install -y git-lfs`

25. **tig**
    - Text-mode interface for Git
    - Usage: `sudo apt-get install -y tig`

26. **subversion**
    - SVN version control system
    - Usage: `sudo apt-get install -y subversion`

### Shell and Terminal Enhancements
27. **zsh**
    - Z shell (alternative to bash)
    - Usage: `sudo apt-get install -y zsh`

28. **fish**
    - Friendly interactive shell
    - Usage: `sudo apt-get install -y fish`

29. **bash-completion**
    - Programmable completion for bash
    - Usage: `sudo apt-get install -y bash-completion`

30. **figlet**
    - ASCII art text generator
    - Usage: `sudo apt-get install -y figlet`

31. **lolcat**
    - Rainbow coloring for terminal output
    - Usage: `sudo apt-get install -y lolcat`

### Python Tools
32. **python3-pip**
    - Python package installer
    - Usage: `sudo apt-get install -y python3-pip`

33. **python3-venv**
    - Python virtual environment tools
    - Usage: `sudo apt-get install -y python3-venv`

34. **python3-dev**
    - Python development headers
    - Usage: `sudo apt-get install -y python3-dev`

35. **ipython3**
    - Interactive Python shell
    - Usage: `sudo apt-get install -y ipython3`

### Database Tools
36. **sqlite3**
    - SQLite database engine
    - Usage: `sudo apt-get install -y sqlite3`

37. **postgresql-client**
    - PostgreSQL client tools
    - Usage: `sudo apt-get install -y postgresql-client`

38. **mysql-client**
    - MySQL client tools
    - Usage: `sudo apt-get install -y mysql-client`

### Utilities
39. **jq**
    - JSON processor for command line
    - Usage: `sudo apt-get install -y jq`

40. **bc**
    - Arbitrary precision calculator
    - Usage: `sudo apt-get install -y bc`

41. **grep (gnu-grep)**
    - Text search utility (usually pre-installed)
    - Usage: `sudo apt-get install -y grep`

42. **sed**
    - Stream editor (usually pre-installed)
    - Usage: `sudo apt-get install -y sed`

43. **awk / gawk**
    - Pattern scanning and processing (usually pre-installed)
    - Usage: `sudo apt-get install -y gawk`

44. **rsync**
    - File synchronization tool
    - Usage: `sudo apt-get install -y rsync`

45. **diff**
    - File comparison tool (usually pre-installed)
    - Usage: `sudo apt-get install -y diffutils`

46. **watch**
    - Execute program periodically (usually pre-installed as part of procps)
    - Usage: `sudo apt-get install -y procps`

### Security Tools
47. **gpg**
    - GNU Privacy Guard
    - Usage: `sudo apt-get install -y gnupg`

48. **fail2ban**
    - Intrusion prevention software
    - Usage: `sudo apt-get install -y fail2ban`

49. **ufw**
    - Uncomplicated Firewall
    - Usage: `sudo apt-get install -y ufw`

### Documentation and Help
50. **man-db**
    - Manual pages (usually pre-installed)
    - Usage: `sudo apt-get install -y man-db`

51. **tealdeer (tldr alternative)**
    - Simplified man pages (Note: install via `cargo install tealdeer` or use tldr-py via pip)
    - Usage: `pip3 install tldr` or install from cargo/snap

## Implementation Priority Suggestions

### High Priority (Most Commonly Needed)
1. **build-essential** - Essential for any development
2. **wget** - Very common network utility
3. **htop** - Better system monitoring
4. **tree** - Useful for directory visualization
5. **python3-pip** - Essential for Python development
6. **zip/unzip** - Common archive format
7. **tmux** - Terminal multiplexer for session management
8. **jq** - JSON processing is very common
9. **net-tools** - Network troubleshooting

### Medium Priority (Useful for Many Users)
1. **nano** - Simpler editor for beginners
2. **neofetch** - Fun system info display
3. **bash-completion** - Improves shell experience
4. **rsync** - File synchronization
5. **sqlite3** - Lightweight database
6. **gdb** - Debugging tool
7. **openssh-server** - Remote access
8. **p7zip-full** - Additional compression format

### Low Priority (Specialized Use Cases)
1. **cmake** - Specific to C/C++ development
2. **tig** - Git power users
3. **fish/zsh** - Alternative shells
4. **fail2ban** - Security-focused users
5. **nmap** - Network analysis
6. **lolcat/figlet** - Terminal aesthetics

## Notes
- Some packages like `git`, `tar`, `sed`, `awk`, `grep`, and `diff` are usually pre-installed on most Linux distributions
- Consider grouping related packages into separate scripts (e.g., `development.sh`, `networking.sh`, `utilities.sh`)
- Always check if a package is already installed before attempting installation
- Consider adding error handling and user prompts for packages that require configuration
