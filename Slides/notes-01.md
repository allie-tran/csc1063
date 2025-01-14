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

_Allie Tran_

**Week 1: Introduction to Unix Systems**


Note:

Hi everyone! Welcome to our first lecture of the semester. I hope you're all ready for an exciting and productive semester ahead. It's great to be back in the classroom, isn't it?

My name is [Your Name], and I'll be your instructor for this module, CSC1063: Managing Enterprise Computer Systems. Over the next few weeks, we'll explore the tools and practices the keep enterprise computer systems running smoothly, from command-line basics to system administration.

--


## Learning Objectives

During this module, you’ll learn how to:
- Manage remote systems—where there’s no clickable interface, only a terminal.
- Work with tools and commands to monitor and control systems.
- Automate tasks to save time and avoid repetitive work.

--

![My first computer|1200x800](https://blog.solidsignal.com/wp-content/uploads/2024/02/iStock-96225501.jpg)


Note:
Just a very important note before we start:

I might not look it, but I’m 28. There’s almost a 10-year gap between us, which isn’t much normally. But in technology, it’s huge. My first computer had a box monitor, and I didn’t have internet access until 2–3 years later. So, my understanding of computer systems may differ wildly from yours. Something obvious to me might not be to you, and vice versa. If you don’t understand something, please don’t hesitate to stop me and ask.

---

## Overview

- Structure: 13 weeks (minus 1 week for reading week)
- Labs: Every Wednesday from 1pm to 3pm
- Assessment: 50% CA, 50% Exam

--

### Lab Portfolio (50%)

- Weekly lab exercises (5% each) - 12 labs (60%)
- Portfolio submission: (40%)
    - Work in groups of 3-4.
    - Create a "capstone script" that integrates multiple skills.
    - Report on your work, contributions, and reflections.
    - Best submissions can be showcased in the final lecture.

--

### Platforms and Communication

- **Module Page**: [https://csc1063.computing.dcu.ie](https://csc1063.computing.dcu.ie)
    - Weekly updated
    - Lab materials, slides, and resources
- **Loop**: Announcements and grades
- **Email**: [allie.tran@dcu.ie](mailto:allie.tran@dcu.ie)
- My email is having issues, so please use messages on Loop for now.

--

#### Module Focus

Specifically, we will focus on **Unix-like systems**, particularly **Linux**.
Most of these will be done in a CLI environment.

[Vevox Participant Link](https://vevox.app/#/m/189786948)

[Vevox Host Link](https://dcu.display.vevox.com#/present/691413/WA757RRNQRJQ9XOB43KA)

Note: https://dcu.vevox.com/#/meeting/687476/polls

---

## Today's Agenda

By the end of this session, you will be able to:
1. Understand the importance of Unix and Unix-like systems.
2. Differentiate between terminals, shells, and processes.
3. Use basic commands and navigate the file system.

---

### Unix and Unix-like Systems

--

#### Operating Systems

- **Operating System (OS)**: Software that manages computer hardware resources and provides services to applications.
- **Responsibilities**:
    - Memory, CPU, and storage management.
    - Runs programs and handles input/output.

![OS](https://upload.wikimedia.org/wikipedia/commons/thumb/e/e1/Operating_system_placement.svg/330px-Operating_system_placement.svg.png)

Note:
“Before we dive into Unix and Linux, let’s start with the basics: what is an operating system?

An Operating System (OS) is the software that manages your computer’s hardware and provides services for applications. It’s the bridge between you and the machine, making sure everything works smoothly.

For example, when you open an app, the OS allocates memory, runs processes, and controls input/output devices like your keyboard and screen. It also handles multitasking—allowing multiple programs to run at the same time.

--

####  Timeline

- 1969: **Unix** developed at Bell Labs—introduced multitasking and multi-user access.
    - Inspiration for many other OSs -> **Unix-like systems**
    - Examples: macOS, iOS, Linux, Android.
- 1991: Linus Torvalds created **Linux**—an open-source OS inspired by Unix.

![Unix vs. Linux](https://cdn.hackr.io/uploads/posts/large/1642729676cijOnNPeSW.png)

Note:
“Now let's have a look at how Linux was created.

In 1969, the Unix OS was developed at Bell Labs, and it revolutionized computing by introducing features like multitasking (running multiple processes at once) and multi-user access (letting several people use the same system). Unix inspired many other operating systems, and such systems are known as Unix-like, like macOS, iOS, Linux, and Android.

In 1991, Linus Torvalds created Linux, an open-source operating system inspired by Unix. Unlike proprietary systems, Linux was free and customizable, which led to its adoption in areas like servers, research labs, and cloud computing. It’s now one of the most popular operating systems in the world.”


--

#### Why Learn Linux?
[Open Vevox](https://dcu.display.vevox.com#/present/691413/WA757RRNQRJQ9XOB43KA)

Note:
Let's play a quick game to test your knowledge of operating systems. I'll give you a picture of devices, and you have to guess if they run on Unix-like systems.

--

**Game: Which OS? Is it part of the Unix family?**

1. iPhone -> iOS (Yes)
2. Samsung Galaxy -> Android (Yes)
3. MacBook -> macOS (Yes)
4. Dell XPS -> Windows (No)
5. LG Smart TV -> WebOS (Linux-based) (Yes)
6. PlayStation 5 -> Orbis OS (FreeBSD-based) (Yes)
7. Xbox Series X -> Xbox OS (Windows-based) (No)
8. Tesla -> Linux-based
9. Google Cloud Servers -> Linux (Yes

--

#### Why Learn Linux?

**Linux is Everywhere**:
- **Servers**: Power websites and cloud services.
- **Supercomputers**: Over 90% of the fastest run Linux.
- **Embedded Systems**: Smart TVs, routers, IoT devices.

> “When we learn Linux, we’re learning how modern computing infrastructure works.”


Note:
“Why focus on Linux? Because it powers almost everything behind the scenes. Over 70% of the world’s web servers run Linux—it’s the backbone of cloud platforms like AWS and Google Cloud.

Linux also dominates in scientific research, powering more than 90% of the world’s fastest supercomputers. And it’s not just for large-scale systems—it’s embedded in everyday devices like smart TVs, routers, and Android phones.

So when we learn Linux, we’re really learning how modern technology is built, from websites to mobile apps and smart home devices.”

--

#### CLI vs. GUI

**Command Line Interface (CLI)**: a text-based interface
- *Efficient*: Fast and supports automation.
- *Remote Access*: Required for GUI-less servers.
- *Powerful*: Access advanced settings.
- *Universal*: Consistent across OSs.

Note:

“Now, let’s talk about the Command Line Interface (CLI). Some people love it, some people hate it, but it’s an essential tool for working with Linux.

Just a personal story, I used to be scared of the CLI, because I didn't really need it unless something was wrong with my computer, and I had to google some tutorials, copy-paste commands, and hope for the best.

But the CLI is more than just a tool for fixing problems. It’s faster and more efficient for many tasks, especially repetitive or complex ones. You can easily automate workflows with scripts, saving time and reducing errors. Also, it’s often the only way to work with remote servers or cloud platforms. Plus, CLIs are consistent across different operating systems, making it a universal skill. Once you get the hang of it, you’ll realise how powerful it really is.”

---

### Terminals, Shells, and Processes

Note: “Now that we understand the context of Unix systems, let’s talk about how we interact with them using the terminal, the shell, and processes.”

--

#### Terminal

- **What it is**: A text-based interface to the OS.
- **Purpose**: Display input/output for commands.

![[Pasted image 20250103171402.png]]

Note:

“So, let’s start with the terminal—one of the core tools you’ll use when working with Linux.

A terminal is essentially a text-based interface to your operating system. Instead of clicking on icons or menus, you type commands to interact with the system with your keyboard.
Now, let’s talk about the shell. A terminal doesn't do much on its own; it needs a shell to process commands.

--

#### Shell

- **What it is**: A *command interpreter* that processes commands and returns output in the terminal.
- **Purpose**: Translates your commands and sends instructions to the OS.

![Prompt | 1200](https://www.linuxtricks.fr/upload/terminal-shell-prompt-commande.png)

Note:

“A shell is a command interpreter. It processes the commands you enter and returns the results.
Once the terminal opens, you’ll see a prompt where you can enter commands. The prompt usually includes your username, the hostname of your computer, and the current directory you’re in, followed by a dollar sign ($). However, this can vary depending on your system and configuration.
When you see the prompt, it means the shell is ready and waiting for your input. You can start typing commands, press ‘Enter’ to execute them, and see the output.

--

- Common shells:
    - `sh` (Bourne shell)
    - `bash` (Bourne Again shell)
    - `zsh` (Z shell)
    - `csh` (C shell)
    - `fish` (Friendly Interactive Shell)
- Default shells:
  - **Linux**: bash
  - **MacOS**: zsh
  - **Windows**: PowerShell

Note:
There are different types of shells, such as:
	•	Bourne shell (sh)
	•	Bourne Again shell (bash)
	•	Z shell (zsh)
	•	Friendly Interactive Shell (fish)

Most Linux distributions use bash by default. On macOS, the default shell is zsh, though you can switch to bash if you prefer. On Windows, there’s PowerShell, but its syntax is different.

--

#### Processes

- **What it is**: The basic unit of work managed by the OS.
- **Purpose**: Executes each command as a new task.
- **Example**: When you type `ls`, the shell creates a process to list files.

```
$ # Example: View active processes:
$ ps aux
```

Note:
A process is the basic unit of work in an operating system. Each time you enter a command, the shell creates a new process. Some processes complete in microseconds, while others may take hours or days. You can run multiple processes simultaneously, and the operating system manages them efficiently.

--

#### Example:

1. You type: `ls -l`
2. Terminal: Displays the shell prompt and waits for input.
3. Shell: Interprets `ls -l` and creates a process.
4. Process: Runs the command, gets the list of files, and sends output back to the shell → displayed in the terminal.

--

**Question: Terminal vs Shell vs Process**

For each description, identify if it refers to a **Terminal**, **Shell**, or **Process**:

1. `___` has a text-based interface.
2) `bash` is a `___`.
3) `___` creates a new `___` for every command executed.
4) `___` executes commands and displays output.
5) `___` runs as the basic unit of work in the operating system.

---

## Command Basics

--

#### What is a Command?

- A **command** is a program that performs a specific task.

```sh
$ command (arg1) (arg2)
```
A sequence of tokens separated by whitespaces
  - **First token**: command name
  - **Subsequent tokens**: arguments

**Examples:**
- `ls` (list files)
- `sleep 5` (wait 5 seconds)
- `echo Hello World` (output message)

--

#### Flags

- **Flags** (or *options*, or *switches*) modify a command's behaviour.
- Added after the command name, preceded by a `-`.

*Examples*: `ls` command
- `ls`: Basic file listing.
- `ls -l`: Long-style listing with details.
- `ls -a`: Includes hidden files
- `ls -al`: Does both

Note:

Some commands have flags to modify their behaviour. Flags, also known as options or switches, are additional arguments that start with a hyphen (-). These are special arguments that start with a hyphen (-). For example, the ls command lists files in the current directory. By adding the -l flag, you get a detailed long listing of files. The -a flag includes hidden files in the list. You can combine flags to get the desired output. For example, ls -al lists all files, including hidden files, in a detailed long format.

--

---

#### Common Commands

[Cheat Sheet](https://csc1063.computing.dcu.ie/files/CheatSheet.pdf)

**File Operations**
- `ls`: List files
- `touch`: Create files
- `rm`: Remove files
- `mkdir`: Create directories
- `rmdir`: Remove empty directories
- `cp`: Copy files and directories
- `mv`: Move files and directories (cut and paste, or rename)

--

**Text Operations**
- `echo`: Output text
- `cat`: Display file contents
- `head`: Display the first lines of a file
- `tail`: Display the last lines of a file

--


What do you think happens when I type `sl` instead of `ls`?

Note:
This is a common mistake that many people make. The ls command lists files in the current directory, while sl is a mistype of ls that displays a train animation. It's a fun command that you can install using a package manager. My point is, the CLI doesn't have to be boring. You can have fun with it and make it your own.

--

**Question: Identify Commands, Arguments, and Flags**

1. `find ./ -type f`
2. `grep doc.txt Mary`
3. `wc -l`
4. `ls -lh /etc`
5. `man -k "file system"`

---

#### man Pages

- **Purpose:**
	- Access detailed descriptions of commands.
- **Usage:**
	- `man command`: Open the manual for a command.
	- Example: `man ls`, `man cat`.

Note:
“If you ever need help with a command, use the man command:
man ls
This opens the manual page for ls.

--
#### man Pages Navigation

- `q`: Quit the manual.
- `/keyword`: Search for a term.
  - Use `n` to jump to the next match, `N` for the previous match.
- **Advanced Options:**  
	- `man -k topic`: Find commands related to a topic.  
Note:

You can search within the manual by typing / followed by your search term. Press ‘n’ to go to the next occurrence, capital ‘N’ to go to the previous occurrence, and ‘q’ to quit the manual.”
If you don’t remember the exact name of a command, you can use `man -k` to search for commands that match a keyword. For example, `man -k copy` will show you commands related to copying files.

--

**Task: Use the man Page**

Open the manual for the `grep` command:
- What does the command do?
- What does the `-i` flag do?
- How would you search for a case-insensitive word “error” in log.txt?

--

**Task: Use the man Page**

Use `man -k` to find commands related to the word "sort":
   - Name at least two commands and their purposes.

---

## The File System

Note:
The final part of today's lecture is about navigating the file system hierarchy.

--

**On Windows**
![[Pasted image 20250103172036.png | 1000x600]]

**Paths**:
- Includes a drive name.
- Uses backslashes `\`.
- `D:\My Documents\TEACHING\105\Grades.xlsx`

Note:
Let’s begin by discussing how the Unix file system differs from the Windows file system.
On Windows, as you can see in this picture, we have multiple drives in My Computer, like C: and D:. A path, which is the location of a file or directory, includes the drive name followed by folders separated by backslashes (\). For example: C:\Users\My Documents\TEACHING\105\Grades.xlsx. Each drive has its own file system hierarchy, and you can't access files on one drive from another without specifying the drive letter.

--

#### On Unix

- The **root directory** `/` is at the top, with all other directories branching below.

![Cornell Virtual Workshop > An Introduction to Linux > Miscellaneous and  Tips > Filesystem](https://cvw.cac.cornell.edu/linux/miscellaneous/filesystem_structure.jpg?v=2TjxA8AXu2ALuM1uSfNrotazjOwuiWgLgdz5v_f2sec)

Paths:
- No drive names; starts with `/` (forward slash).
- `/home/jolo/Project`
- *Folders* are called **directory**

Note:
In contrast, Unix-based systems like Linux and macOS have a single unified file system hierarchy. The root directory (/) is at the top, and all files and directories are organized under it. Paths in Unix start from the root directory and use forward slashes (/) to separate directories,  just like on the web. For example: /home/user/Documents/assignments. "Folders" on Unix systems are called "directories."

--

![Cornell Virtual Workshop > An Introduction to Linux > Miscellaneous and  Tips > Filesystem](https://cvw.cac.cornell.edu/linux/miscellaneous/filesystem_structure.jpg?v=2TjxA8AXu2ALuM1uSfNrotazjOwuiWgLgdz5v_f2sec)

**Tree Structure:**
```plaintext[]
/
├── bin
├── etc
├── home
│   ├── jolo
│   │   ├── Project
│   │   ├── Results
│   ├── jdoe
│       ├── Documents
├── usr
│   ├── bin
│   │   ├── ls
│   │   ├── who
│   ├── include
├── var
```

Note:
Usually, the structure of the Unix file system can be represented in a plain text format like this. Root (/) is at the top. However, instead of branching out horizontally like in the diagram, we use vertical lines.

--

```plaintext[]
/(root)
├── bin
├── etc
│   ├── zshrc
│   ├── apache
├── home
│   ├── allie
│       ├── Desktop
│       ├── Documents
```

**Can you locate the following?**

```sh[]
/etc
/etc/zshrc
/home/allie
```
---

### Special Directories

- **Root Directory**: `/`
- **Home Directory**: `~`
- **Current Directory**: `.`
- **Parent Directory**: `..`

--

#### Root Directory

> Special symbol: **/**

The top-level directory in the file system.

--

#### Home Directory
> Special symbol: **~** (tilde).
- Each user has a home directory.
- Examples:
    - Full path: `/home/allie/Desktop`
    - Shortcut: `~/Desktop`

Note:
Each user has a home directory, which is usually located at /home/username. For example, if your username is ‘alice’, your home directory would be /home/alice. This is where you store your personal files and configurations. Just like how you have a room in a house, your home directory is your space on the system. ~ is a shortcut that represents your home directory.

--

#### Current Working Directory (CWD)
> Special symbol: `.` (dot)
- The directory you are currently in. When you open a terminal, the CWD is your home directory.
- Example: `./file.txt`, `./Documents`
- Commands:
    - `pwd`: check the CWD.
    - `cd [path]`: change the CWD to a new path.

Note:
The current working directory (CWD) is the directory where you are “standing” in the file system. When you open a terminal, your CWD is usually set to your home directory (/home/username).
You can use the special symbol . to represent the current directory. For example, ./file.txt refers to a file named file.txt in the current directory.
To check your current location, you can use the pwd command, which stands for “print working directory.” This command will display the full path of the current directory.
To change your current directory, you use the cd command followed by the path you want to move to. For example, `cd /home/username/Documents` would move you to the Documents directory in your home folder.

--

#### Parent Directory
>Special symbol: `..` (2 dots)
- The directory above the CWD.
- Examples:
	- `cd ../Downloads`
	- `cd ../../jdoe/Documents`

--

**Example:**

```plaintext[]
/
├── bin
├── etc
├── home
│   ├── jolo
│   │   ├── Project (CWD)
│   │   ├── Results
│   ├── jdoe
│       ├── Documents
├── usr
```
- parent of `/home/jolo/Project` is `/home/jolo`
- parent of `~/Project` is `~`

---

### Path Navigation

- **Goal:** Move between directories.
- **Methods:**
    - **Absolute Path**: Full path from the root directory.
    - **Relative Path**: Path from the CWD.

Note: Many commands in Unix require you to specify paths to files or directories. If you don’t know where you are in the file system, you might reference the wrong files, leading to errors or unintended consequences.
There are two ways to specify paths: absolute and relative.

--

#### Absolute Path

- Starts from the root directory `/`.
- Example: `/home/allie/Documents`

--

#### Relative Path

- Starts from the CWD.
- Example: `Documents` (from `/home/allie`)
- Example: `Documents/CS1063/lecture.txt`

--

#### Changing the CWD

- **Command**: `cd` (change directory).
- **Usage**: `cd [path]`

```sh[]
$ cd /home/allie/Documents # Absolute path
$ cd Documents # Relative path
$ cd / # Go to Root
$ cd ~ # Go to Home
$ cd # Go to Home (no argument)
```
--

#### Moving Up

```sh[]
$ cd .. # Move up one directory
$ cd ../Downloads # Move up and then to Downloads
$ cd ../../ # Move up two directories
```

--

**Question: Special Directories**
Match the following directories to their names:
1. `~`
2. `.`
3. `..`
4. `/`

- **A.** Root directory
- **B.** Home directory
- **C.** Current directory
- **D.** Parent directory

--

**Task: Navigation Challenge**

Given the directory structure:

```plaintext[]
/
├── home
│   ├── user
│       ├── Documents (target)
│       ├── Downloads (CWD)
├── etc
│   ├── apache
│   ├── zshrc
```

Starting at `/home/user/Downloads`, navigate to `/home/user/Documents`.

--
**Task: Navigation Challenge**

Given the directory structure:

```plaintext[]
/
├── home
│   ├── user
│       ├── Documents (target)
│       ├── Downloads (CWD)
├── etc
│   ├── apache
│   ├── zshrc
```

Starting at `/home/user/Downloads`, navigate to `/home/user/Documents`.
```sh[]
$ cd /home/user/Documents
$ cd ../Documents
```

---

## Some more useful commands

--

Command | Description
--- | ---
`clear` | Clear the terminal screen
`history` | Show a list of recent commands
`!n` | Repeat the nth command
`!string` | Repeat the last command starting with `string`
`!c` | Repeat the last command starting with `c`
`!!` | Repeat the last command

---
## Conclusion

In this session, we have covered:
1. The importance of Unix and Unix-like systems
2. The basic structure of Unix and Unix-like systems
3. The basic commands used
4. The file system structure

---

## Extra Material

---

### Tab Completion

Pressing `Tab` can complete commands, paths, and filenames.

Examples:
- `dat` + `Tab` completes to `date`.
- `cat fi` + `Tab` completes to `cat file.txt` (if `file.txt` exists).
- `cd ~/Doc` + `Tab` completes to `cd ~/Documents`.
- If there are multiple matches, press `Tab` twice to see all options and cycle through them.

---

### Shortcuts

- **Up/Down Arrows**: Cycle through command history.
- **Ctrl + C**: Cancel the current command.
- **Ctrl + D**: Exit the shell.
- **Ctrl + L**: Clear the terminal screen.
- `clear` command also does this.
- `history` command shows a list of recent commands.
