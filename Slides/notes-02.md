---
theme: css/dracula.css
transition: slide
duration: 1h
classSize: ~50
width: 1920
height: 1280
minScale: 0.1
timeForPresentation: 3600
progress: true
navigationMode: default
view: scroll
center: false

---

# CSC1063
Managing Enterprise Computer Systems

**Week 2: Starting Up**

---

## Today's Agenda

1. Basic System Management
2. File Handling
3. Scripting Basics

---
## Recap: Last Week

- Introduction to Unix:
    - History and significance.
    - Our lab environment: Ubuntu (Linux).
- Terminology:
    - Terminals, shells, processes.
    - Command-line interface (CLI).
- File System Navigation
    - Basic commands: `ls`, `cd`, `pwd`.
    - Absolute and relative paths.

---
## Basic System Management

- **Package Management**:
    - Installing, updating, removing packages.
    - Checking installed packages.
- **Disk Usage**:
    - Checking disk space.
- **Configurations**:
    - Environment variables.
    - Configuration files.

---
### Package Management

- **Purpose**: Download, install, and manage software packages.
- **Tools**:
    - `apt` (Debian, Ubuntu) or `apt-get` (older versions)
    - `yum` (Red Hat, CentOS)
    - `dnf` (Fedora)
    - `brew` (macOS)
- **Commands**:
    - `install`, `remove`, `update`, `upgrade`

Note:
Now that's you've set up your system, you might want to install additional software. Package managers are tools that help you download, install, and manage software packages. They handle dependencies, updates, and removals, making it easier to manage software on your system.

Some common package managers include apt (used in Debian and Ubuntu), yum (used in Red Hat and CentOS), dnf (used in Fedora), and brew (used in macOS). These package managers have commands like install, remove, update, and upgrade that you can use to manage software packages.

--

#### Installing Software (apt)

- First update the package list:
```sh
$ sudo apt update
```
- Install a package:
```sh
$ sudo apt install [package]
```
- Remove a package:
```sh
$ sudo apt remove [package]
```
- Upgrade (to latest versions):
```sh
$ sudo apt upgrade [package]
$ sudo apt upgrade # All packages
```

Note:
To install software using apt, you first need to update the package list with sudo apt update. This ensures you have the latest information about available packages. Then you can install a package with sudo apt install [package]. To remove a package, use sudo apt remove [package]. To upgrade a package to the latest version, use sudo apt upgrade [package]. If you want to upgrade all packages, use sudo apt upgrade without specifying a package.

Note that you need to use sudo to run these commands with administrative privileges. This is because installing and removing software affects the system and requires special permissions.
- **apt** (Debian/Ubuntu):
    - `apt install <package>`
    - `apt update`
    - `apt upgrade`
    - `apt remove <package>`
- **yum** (Red Hat/CentOS):

--

#### Checking Installed Packages

- `which`: Find the location of a command.
- `type`: Determine a command's type.

```sh
$ which ls
/bin/ls
$ type ls
ls is /bin/ls
```

---

### Disk Usage

+ **Scenario**: You are about to install a large software package. How do you check if you have enough disk space?
+ Check the total, used, and available space on your disk.
    - `df`(*d*isk *f*ree)
    - Example: `df -h` (human-readable format)

--
### Disk Usage (contd.)

+ **Scenario**: You can't install a package because your disk is full. How do you find large files or directories to delete?
+ Check the disk usage of files and directories.
    - `du`(*d*isk *u*sage) - works recursively.
    - Example: `du -sh /path/to/dir` (total disk usage of a directory)
    - Example: `du -ah /path/to/dir` (disk usage of all files in a directory)

---

### Configurations

System-wide settings and configurations are stored in:
- Environment Variables
- Configuration Files

--

#### Environment Variables

- **Purpose**: Store system-wide settings.
- **Common Variables**:
    - `EDITOR`: Default text editor.
    - `PATH`: Directories to search for executables.
    - `HOME`: User's home directory.
- To see a variable's value: `echo`, `printenv`.
    - `echo $HOME`
    - `printenv PATH`
- To modify a variable: `export`, `unset`.
    - `export EDITOR=nano` (temporary)
    - `unset EDITOR`

--

### Configuration Files

- **Purpose**: Store system and application settings.
- **Locations**:
    - System-wide: `/etc`
    - User-specific: `~/.config`, or home directory.
    - Application-specific: `~/.appname`
- **Examples**:
    - Shell configuration: `~/.bashrc`
    - Text editor settings: `~/.vimrc`, `~/.nanorc`
    - SSH configuration: `~/.ssh/config`

Instead of `export`, which is temporary for the current session, you can add these variables to your shell configuration file (e.g., `~/.bashrc`) to make them persistent across sessions.

--

### My .bashrc

```sh
# Set vim as the default editor
export EDITOR=vim

# Add Einstein to the PATH
export PATH=$PATH:~/Downloads/einstein

# Set the default prompt
PS1="\u@\h:\w\$ "
```

--

### SSH Configuration
If you frequently connect to a remote server:
```sh
$ ssh [username]@student.computing.dcu.ie
```
You can create an SSH configuration file to simplify this:
```plaintext
# ~/.ssh/config
Host SoC
    HostName student.computing.dcu.ie
    User [username]
    Port 22
```
Now you can connect with:
```sh
$ ssh SoC
```

---

## File Handling

- **Downloading Files**:
    - `wget`, `curl`
- **Searching for Files**:
    - `find`, `locate`
- **Opening and Editing Files**:
    - `nano`, `vim`
- **Outputting File Contents**:
    - `echo`, `cat`

---

### Downloading Files

- **wget**: Download files from the web (and save to disk).
    - `wget [URL]`
    - `wget -O [filename] [URL]` (save as a different filename)
- **curl**: Transfer data with URLs (and display on terminal).
    - `curl [URL]`
    - `curl -o [filename] [URL]` (save as a file)

You may need to install `wget` or `curl` if they are not already available on your system.
If this is the case, you'd see an error message like "Command not found".

```sh
$ curl https://example.com/file.text
bash: curl: command not found
$ sudo apt install curl
```

Again you need to use `sudo` to install software packages.

---

### Searching for Files

>**Scenario**: You downloaded a file yesterday but can't remember where you saved it. How do you find it?

**The `find` utility**: Search for files in a directory hierarchy.

```sh
$ find [PATH...] [EXPRESSION]
```

Where:
- `PATH...`: a list of directories to search (can be omitted).
    - When omitted, searches the current directory.
    - Can be multiple directories.
- `EXPRESSION`: search criteria with flags (e.g., `-name`, `-type`).

--

**Examples**:

```sh
# Output a list of all files and directories in or under your home directory.
$ find ~

# Output a list of all files and directories in or under the current working directory.
$ find

# Output a list of just the files in or under your home directory.
$ find ~ -type f

# Output a list of just the directories in or under your home directory.
$ find ~ -type d

# Output a list of all of your downloaded files.
$ find ~/Downloads -type f
```

--

>**Scenario**: if the directory structure is too large, `find` can be slow. You can interrupt the search with `Ctrl + C`.

```
$ find / -type f # This will take a while...
```

Some common shortcuts:
- `Ctrl + C`: Interrupt and stop the current command.
- `Ctrl + Z`: Suspend the current command (to resume, use `fg`).
- `Ctrl + D`: Exit the current shell session.

--

+ **Scenario**: The command gets very long and hard to read...

```
$ find / -name "*.txt" -type f -size +1M -exec ls -lh {} \;  # ignore this for now
```

You can use several lines by typing `\` and pressing `Enter` to continue on the next line.

```sh
$ find / -name "*.txt" \
> -type f \
> -size +1M \
> -exec ls -lh {} \;
```

--

#### Globbing and Wildcards

Sometimes we don't know the exact filename, but we know part of it or a pattern.

- **Globbing**: Pattern matching for filenames containing wildcards.
    - `*`: Zero or more characters.
    - `?`: Any single character.
    - `[abc]`: Any character in the set.
    - `[a-z]`: Any character in the range.
- `*.txt` is called a **glob pattern**.

--

#### Globbing and Wildcards (contd.)

Some examples:

```sh
# List all PDF files.
ls -l *.pdf

# List all PDF files which filename has 2 Characters.
ls -l ??.pdf

# List all PDF files with certain patter.
ls -l a[a,b]a.pdf
ls -l a[!c]a.pdf

# Output all lines of all JavaScript files which contain the text "function".
grep function *.js
```

--

#### Examples

- `ls *.txt`: List all text files in the current directory.
- `ls file?.txt`: List files like `file1.txt`, `file2.txt`, etc.
- `ls file[1-3].txt`: List files like `file1.txt`, `file2.txt`, `file3.txt`.
- `find /path/to/dir -name "file*.txt"`: Find all text files starting with "file".

---

### Opening and Editing Files

- **nano**: Simple text editor.
    - `nano [filename]`
    - `Ctrl + O` (save), `Ctrl + X` (exit)
- **vim**: Advanced text editor.
    - `vim [filename]`
    - `i` (insert mode), `Esc` (command mode)
    - `:wq` (save and exit), `:q!` (exit without saving)
    - `:help` (help)

I use `vim` for most of my editing tasks, but `nano` is easier for beginners.

---

### Outputting File Contents

- **echo**: Print a line of text.
    - `echo "Hello, World!"`
    - `echo $HOME`
- **cat**: Concatenate and display files.
    - `cat [filename]`
    - `cat file1 file2 > combined.txt` (combine files)

---

### File Handling Commands

- **mv**: Move files and directories.
    - `mv [source] [destination]`
    - `mv file1.txt /path/to/dir`
- **cp**: Copy files and directories.
    - `cp [source] [destination]`
    - `cp file1.txt /path/to/dir`
- **rm**: Remove files and directories.
    - `rm [filename]`
    - `rm -r [directory]` (recursive)
- Used with wildcards for multiple files.
    - `mv *.txt /path/to/dir` (move all text files)
    - `cp *.txt /path/to/dir` (copy all text files)
    - `rm *.txt` (remove all text files)

---

## Scripting Basics

--

The shell doesn't just run commands interactively. It can also read commands from a file (a **shell script**) and execute them sequentially.

It can be used to automate repetitive tasks, create custom commands, and more.

---

### Shell Scripts

- A **text file** containing a sequence of commands.
- Named with a `.sh` extension (convention, not required).
- Begin with a **shebang line**:
    - `#!/bin/sh` (use the `sh` shell)
    - `#!/bin/bash` (use the `bash` shell)

```sh
#!/bin/sh
echo "Hi! I'm in a shell script."
```

---

### Running Scripts
In the terminal, you can run a script using the `sh` command: `sh script.sh`.

Or you can make the script **executable** and run it directly:
```sh
$ chmod +x script.sh
$ ./script.sh
```

**Note**: You only need to make a script executable once.

--

#### Example: Update Script

We can create a file `update.sh` with a text editor (like `nano` or `vim`) and add the following commands:

```sh[]
#!/bin/sh
sudo apt updates
sudo apt upgrade
```

So when you run `sh update.sh`, it will first identify the shell to use, then sequentially run the commands in the script: line 2 **then** line 3.

-- 

#### Comments

- **Comments**: Lines that are not executed.
- **Purpose**: Document scripts for yourself and others.
- **Syntax**: start with `#`.

```sh
#!/bin/sh

# This is a comment
echo "Hello, World!" # also a comment
```

--

#### Adding scripts to PATH

Remember when you run `script.sh`, you need to be in the same directory as the script (or provide the full path).

> If you have a script you use frequently, you can add it to your `PATH` so you can run it from anywhere.

`PATH` is an environment variable (that we discussed earlier) containing directories to search for executables.

```sh[]
$ export PATH=$PATH:/path/to/script
```

Now you can run the script from anywhere:

```sh
$ script.sh
```

---

## Summary

- **Basic System Management**:
    - Package management, disk usage, configurations.
- **File Handling**:
    - Downloading, searching, opening, editing, outputting files.
- **Scripting Basics**:
    - Shell scripts, running scripts, comments, adding scripts to PATH.

