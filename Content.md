## Learning Objectives
1. download, install, configure, upgrade and remove system software packages, including starting and stopping daemon services
    - week 2 (package management) and week 12 (managing services)
2. use the command shell to administer a Unix-like operating system, including basic shell commands, the Unix manual, and a text editor
    - throughout the course
3. write short shell scripts to automate simple repetitive and scheduled tasks
    - week 5 (more on scripting)
4. create and remove user accounts, including the allocation and deallocation of resources
    - week 2 (disk quotas)
    - week 11 (user management and user permissions) and week 12 (scheduled tasks and services)
5. locate files accurately and correctly within standard files system hierarchies
    - week 1 and 2
6. maintain basic system backups and restore lost or corrupted files
    - week 12 (scheduled tasks and services)
7. use standard shell tools within short shell scripts
    - throughout the course
8. use standard shell tools to troubleshoot operating systems issues and to rectify those issues
    - week 6 (debugging and troubleshooting) and week 12 (scheduled tasks and services)


## Week 1: Introduction to Linux/Unix and File System Navigation

**Learning Objective Focus**: Learn to navigate the file system and perform basic directory operations.
**Lecture Content**:
	- Introduction to Linux/Unix.
	- Basic commands: ls, cd, pwd.
	- Navigating directories.
	- Absolute vs. relative paths.

**Lab Exercises**:
	- Logging into Linux.
	- Navigating directories and creating folders.
	- Familiarization with the terminal.

**Assessment**: Installing Linux – No marks.

## Week 2: Setting Up

**Learning Objective Focus**:
Learn to create, edit and manage files using the command line and text editors.
Download, install, configure, upgrade, and remove system software packages (Objective 1).

**Lecture Content**:
    - Package management: 
        - Installing, updating, removing: apt, yum.
        - Checking installed packages: which, type.
    - Text editors: nano, vim.
        - echo, cat.
        - Opening, editing, saving files.
        - Editing scripts and configuration files.
    - Downloading files:
        - wget, curl.
        - Searching for files: find, locate.
        - Wildcards/Pattern matching/Globbing.
    - Disk usage and File Sizes: df, du.
    - Environment variables: (briefly)
        - EDITOR, PATH, HOME
        - Modifying environment variables.
    - Basic Shell Scripting:
        - Editing files.
        - Introduction to scripting.
        - Running scripts: chmod +x, ./script.sh.

**Lab Exercises**:
- Task: “Setting Up a Configuration Script”
	1.	Install vim using apt.
	2.	Download a sample configuration file using wget.
	3.	Edit the file to include your name and save it.
	4.	Create a simple script to print “Setup complete” and save it as setup.sh.
	5.	Run the script after making it executable.
	6.	Check disk usage before and after downloading a file.

**Assessment**: Lab submission – 5%.

## Week 3: IO Redirection and Pipes
**Learning Objective Focus**: Learn to combine and redirect command input and output.

**Lecture Content**:
    - Standard input/output/error.
    - Redirection: >, >>, <
    - Pipes: |.
    - Combining commands.

**Lab Exercises**:
    - Redirect output to a file.
    - Use pipes to combine commands.
    - Practice with standard input

## Week 4: Text Processing and Manipulation

**Learning Objective Focus**: Learn to process and manipulate text using standard Unix/Linux commands.
**Lecture Content**:
    - Text processing: grep, sed, awk, cut, uniq, sort, wc.
        - Searching for text: grep.
        - Filtering and Cutting Data: cut (extract columns) and sort
        - Deduplicating and Counting: uniq, wc.
        - Editing text: sed.
        - Manipulating text: awk.
    - Regular expressions (to use with grep).
    - More on pipes and redirection.

**Lab Exercises**:
    - Use grep to search for text.
    - Use sed to replace text.
    - Practice with awk to manipulate text.
    - Combine commands to process text.

**Assessment**: Lab submission – 5%.

## Week 5: Scripting Basics - Variables and Automation

**Learning Objective Focus**: Learn to write basic shell scripts to automate repetitive tasks.

**Lecture Content**:
    - Variables.
    - Command-line arguments.
    - Example: Automate Package Management with a Script (to review package management).
    - Special variables.
    - New-line characters (IFS).
    - Quoting: single, double, backticks, escape.
    - Read command.

**Lab Exercises**:
    - Write a script with variables.
    - Use command-line arguments in a script.
    - Practice with special variables.
    - Use the read command in a script.
    - Practice with quoting.

**Assessment**: Lab submission – 5%.

## Week 6: Debugging and Troubleshooting

**Learning Objective Focus**: Learn to debug scripts and troubleshoot common issues
**Lecture Content**:
    - Exit status.
    - Error messages.
    - Common script errors.
    - Debugging tools: bash -x, set -e.
    - Log analysis: /var/log, journalctl.
        - Point out error logs from services (cron, ssh)
    - Example: reinstalling a package

**Lab Exercises**:
    - Debug a broken script.
    - Use logs to diagnose and resolve a simulated issue.
    - Lab Exam 1: Covers topics from Weeks 1–5 (e.g., file system navigation, scripting basics, file permissions).
    - “What service wrote this entry to the log?” (Answer: Use systemctl status to check if the service is running.)


**Assessment**: Lab exam 1 – 30%.

## Week 7: Reading Week

Skip

## Week 8: Conditionals

**Learning Objective Focus**: 

**Lecture Content**:
    - Test command.
    - Conditional tests: string, integer, file.
    - Logical operators: and, or, not.
    - Conditional execution: &&, ||.
    - Control structures: if, elif, else.
    - Example: Check if a package (nginx or htop) is installed

**Lab Exercises**:
    - Write a script with conditionals.
    - Practice using variables.
    - Use logical operators in a script.
    - Control the flow of a script with conditionals.
    - Use a time-based condition - hint at cron jobs.

**Assessment**: Lab submission – 5%.

## Week 9: Loops

**Learning Objective Focus**:
**Lecture Content**:
    - Loops: for, while.
    - Loop control: break, continue.
    - Shift command.
    - Looping through arguments: $@.
    - Looping through a file: IFS and read.
    - Looping through files: for and wildcards.

**Lab Exercises**:
    - Write scripts with loops.
    - Automate a task using conditionals (e.g., checking file existence).
    - Practice with loops and arguments.
    - Loop through a file.

**Assessment**: Lab submission – 5%.

## Week 10: Environment Variables and Arithmetic Operations in Scripts

**Learning Objective Focus**:
**Lecture Content**:
    - Arithmetic operations: $(( )).
    - Environment variables.
    - Export command.
    - Command substitution.
    - Command substitution vs. arithmetic substitution.

**Lab Exercises**:
    - Write a script with environment variables.
    - Use the export command.
    - Practice with command substitution.
    - Use arithmetic operations in a script.

## Week 11: User and Resource Management

**Learning Objective Focus**:
**Lecture Content**:
    - User management: adduser, userdel, usermod.
    - Assigning resources: disk quotas.
    - Group management: addgroup, groupdel, groupmod.
    - File permissions: chmod, chown.
    - File ownership.
    - User and group permissions.

**Lab Exercises**:
    - Create and delete user accounts.
    - Set disk quotas.
	- Write a script to automate user creation.
    - Set file permissions.
    - Practice with user and group management.
    - Use file ownership and permissions.

**Assessment**: Lab submission – 5%.

## Week 12: Managing Services and Backups

**Learning Objective Focus**: Manage system software and automate tasks (Objective 1, 3).
**Lecture Content**:
	- Task scheduling with cron.
	- Managing services with systemctl.
    - Backup: tar, rsync.
    - Restoring corrupted files.

**Lab Exercises**:
	- Schedule a script with cron.
	- Start and stop a service (e.g., nginx).
    - Create and restore backups.
    - Simulate and recover from a corrupted file.

**Assessment**: Lab submission – 5%.


## Week 13: Final Integration and Lab Exam 2

**Learning Objective Focus**: Integrate all objectives (1–8).
**Lecture Content**:
	- Capstone review of all topics.

**Lab Exercises**:
	- Lab Exam 2: Integration task (e.g., user management, service configuration, backup automation, troubleshooting logs).

**Assessment**: Lab Exam 2 – 30%.

---

