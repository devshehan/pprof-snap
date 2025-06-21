# pprof-snap-tool

> The goal is to enable quick profiling for developers with minimal setup and maximum clarity. Stay sharp and iterate fast.

A simple shell tool that quickly captures pprof profiles from target servers and saves them as `.png` images, organized in a clean, server-specific directory structure.

### Prerequisites:
> * Go install (version 1.22 or newer)
> * Server should enable debug port

### Final Directory Structure:
```bash
    ~/Desktop/
    ├─ 192.168.1.100/
    │  └─ 20250621123456.png
    │  └─ 20250621153456.png
    ├─ 192.168.1.120/
    │  └─ 20250621155056.png
```

### Usage: 
```bash
    pprof-fetch <ip_address>
```
Example: 
```bash
    pprof-fetch 192.168.1.100
```
---

### Installation:
1. Clone this repository.
2. Run the installer script.
```bash
    chmod +x install.sh
    ./install.sh
```
This will:  
* Create `$HOME/.local/bin` if not exist.  
* Install pprof-snap tool.
* Make alias in your `/.bashrc` for quick access.

After installation, open a new terminal or run:
```bash
    source ~/.bashrc
```

### Notes
 * All the files save under the `Desktop` directory for quick access.


Author  
Shehan Avishka  
Date: 21st June 2025



