---
theme: css/dracula.css
highlightTheme: css/rose-pine-moon.css
transition: slide
duration: 1h
classSize: ~102
width: 1917
height: 1280
minScale: -3
timeForPresentation: 3600
progress: true
navigationMode: default
view: scroll
center: false
embedded: "true"
---

# CSC1063
Managing Enterprise Computer Systems

**Week 9: User Managements, Permissions, and Networking Basics**

---

# Today's Agenda

1. User Accounts
2. File Permissions
3. Group Management
4. Networking Basics

---

# Multi-User Systems

- Multiple users can use the system at the same time.
- Users have different levels of access.
- `root` user: Superuser with full access.
- Group: A collection of users with shared levels of access.

Note:
As we mentioned in the first lecture, Linux is a multi-user system. This means that multiple users can use the system at the same time. For example, you can have multiple users logged in to the same system via the command line or remotely via SSH.

However, it should not be assumed that all users have the same level of access to the system. This is done so that users can only access the resources they need to do their work and to prevent accidental or intentional damage to the system or other users' files. The `root` user has the highest level of access and can do anything on the system, while other users have limited access.

Similarly, users can be grouped together based on their roles or permissions. For example, you can have a group called `students` in the server, and another group called `staff` with different levels of access to the system.

--

## `su`

`su`: Command to switch to another user account.

```sh
$ su <username>
```

You will be prompted for the user's password.

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="200"></iframe>

Note:
The `su` command is used to switch to another user account. This can be useful if you need to perform some tasks on files or directories that are owned by another user.
When you run the `su` command, you will be prompted for the password of the user you want to switch to. If you enter the correct password, you will be switched to that user's account.

--

## `sudo`

`sudo`: Command to run a command as the superuser.

```sh
$ sudo <command>
```
![sudo|1200x800](https://imgs.xkcd.com/comics/sandwich.png)

Note:
Sometimes you may need to run a command as the superuser (root) to perform administrative tasks. The `sudo` command allows you to do this. When you run a command with `sudo`, you will be prompted for your password. If you enter the correct password, the command will be run with superuser privileges.

There is a famous XKCD comic about `sudo` that illustrates this point well.

--


`sudo` only works if you are in the `sudo` group.

![Incident|1200x800](https://imgs.xkcd.com/comics/incident.png)


Note:
Another point is that `sudo` only works if you are in the `sudo` group. If you are not in the `sudo` group, you will not be able to run commands with `sudo`. This is a security feature to prevent unauthorized users from running commands with superuser privileges.

--

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="800"></iframe>

---

# User Management

Note:
User management is an essential part of system administration. It involves creating, modifying, and deleting user accounts.

--

### User Information

```sh
$ id
uid=1000(user) gid=1000(user) groups=1000(user)
```

- **uid**: User ID (0 is reserved for root)
- **gid**: Group ID (0 is reserved for root)
- **groups**: Supplementary groups

Note:
To see information about the current user, you can use the `id` command. This command will display the user ID (uid), group ID (gid), and supplementary groups that the user belongs to. The user ID is a unique number assigned to each user account, with 0 reserved for the root user. The group ID is a unique number assigned to each group, with 0 reserved for the root group.

--

### /etc/passwd

- Contains information about user accounts.
- It is a text file, so it can be edited with a text editor.
- Can be read by anyone, but only the superuser can write to it.

```sh
root:X:0:0:root:/root:/bin/bash
user:X:1000:1000:user:/home/user:/bin/bash
```

line format: `username:password:UID:GID:comment:home:shell`
password field is now unused, and is replaced with `x`.

Note:
The `/etc/passwd` file contains information about user accounts. It is a text file, so it can be edited with a text editor. The file can be read by anyone, but only the superuser can write to it. The file contains one line for each user account, with fields separated by colons.

--

### /etc/shadow (shadow password file)

- Contains encrypted passwords and other information about user accounts.
- Only specific programs can read this file.

```sh
root:＄6＄1V5z3z3z＄:12345:0:99999:7::
user:$6$1V5z3z3z＄:12345:0:99999:7::
```

line format: `usrname:passwd:...`

--

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="500"></iframe>

--

### Adding a User

- `useradd`: Command to add a new user account.

```bash
$ sudo useradd jane
$ sudo useradd jane sudo # add jane to sudo group
```

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="300"></iframe>

--

### Changing Password

- `passwd`: Command to set a password for a user account.

```bash
$ passwd # change your password
$ sudo passwd jane # change jane's password
```

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="300"></iframe>

--

### Removing a User

- `userdel`: Command to remove a user account.
```
$ sudo userdel user
$ sudo userdel -r user
```
`-r`: Remove the user's home directory and mail spool. Be careful with this option!

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="300"></iframe>

note: there might be files owned by the user in other directories.
some files might be owned by the user, and removing the user will make them inaccessible.
some files in the user's home directory might be owned by other users, and removing the user will make them inaccessible.

--

### Changing User Information

- `usermod`: Command to modify a user account.

```sh
$ sudo usermod -g newgroup jane # change the primary group
$ sudo usermod -s /bin/zsh jane # change the default shell
$ sudo usermod -l newname jane # change the username
```

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="300"></iframe>

--

Other options:

- `-d`: Change the user's home directory.
- `-g`: Change the user's primary group.
- `-G`: Change the user's supplementary groups.
- `-l`: Change the user's login name.
- `-s`: Change the user's login shell.
- `-u`: Change the user's UID.
- `-L`: Lock the user account.
- `-U`: Unlock the user account.

---

## Group Management

Groups: A collection of users, with a group ID (GID) and a list of members.

Note:
Groups are used to manage users and their permissions. A group is a collection of users who share the same permissions. For example, you can have a group called `staff` that contains all the users who work in the same department. In the SoC Server, you are part of a group called `students`.

--

### Group Information

```sh
$ id
uid=1000(user) gid=1000(user) groups=1000(user),27(sudo)
$ groups
user sudo
```

- **user**: Primary group
- **sudo**: Supplementary group

--

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="600"></iframe>

--


### /etc/group

- Contains information about groups.
- Similar to `/etc/passwd`, but for groups.

```
root:X:0:root
bin:X:1:root,bin,daemon
sys:X:2:root,bin,adm
students:X:1000:bob,alice,joe
staffs:X:1001:alice,joe
```

line format: `groupname:password:GID:members`

--

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="700"></iframe>

--

## Commands

- `groupadd`: Command to add a new group.
- `groupdel`: Command to remove a group.
- `groupmod`: Command to modify a group.

```sh
$ sudo groupadd newgroup
$ sudo groupdel newgroup
$ sudo groupmod -n newname oldname
```

--

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="700"></iframe>

---

## File Permissions

Can be set for files and directories.

- `read` (`r`): Allows the file to be read.
- `write` (`w`) : Allows the file to be modified.
- `execute` (`e`): Allows the file to be executed

--

### Viewing File Permissions

```sh
$ ls -l
total 2
-rw-r--r-- 1 user user 0 Nov  1 00:00 file
-rw-r--r-- 1 user user 0 Nov  1 00:00 file2
drwxr-xr-x 2 user user 0 Nov  1 00:00 folder
```

`-rw-r--r--`: File permissions

--

- First character: Type of file (d: directory, -: regular file)
- Next 3 characters: Owner permissions (user)
- Next 3 characters: Group permissions (default: user's group)
- Next 3 characters: Other permissions (everyone else)
- `r`: Read
- `w`: Write
- `x`: Execute
- `-`: No permission

--

### Execute

- For files: Allows the file to be executed as a program.
- For directories: Allows the directory to be accessed.

--

**Examples**:

- `executable.sh`: A script that can be executed.
- `normal-script.sh`: A script that cannot be executed.

```sh
$ ls -l
-rw-r--r-- 1 user user 0 Nov  1 00:00 normal-script.sh
-rwxr-xr-x 1 user user 0 Nov  1 00:00 executable.sh

$ ./normal-script.sh # permission denied
$ ./executable.sh # ok
```

--

## Changing File Permissions

- `chmod`: Command to change the permissions of a file or directory.
- **syntax**: `chmod [options] mode file`

```sh
$ chmod u+x file # add execute permission for user
$ chmod g-w file # remove write permission for group
$ chmod o-r file # remove read permission for others
$ chmod a=r file # set read permission for all
```

--

#### Permissions Codes

| Permission | Octal | Binary | Description              |
| ---------- | ----- | ------ | ------------------------ |
| ---        | 0     | 000    | No permissions           |
| --x        | 1     | 001    | Execute                  |
| -w-        | 2     | 010    | Write                    |
| -wx        | 3     | 011    | Write and execute        |
| r--        | 4     | 100    | Read                     |
| r-x        | 5     | 101    | Read and execute         |
| rw-        | 6     | 110    | Read and write           |
| rwx        | 7     | 111    | Read, write, and execute |

- `666`: Read and write for everyone (-rw-rw-rw-).
- `777`: Full permissions for everyone (usually for directories) (drwxrwxrwx).

--

**Example**:

```sh
$ chmod 644 file # set permissions to 644
$ chmod -R 755 folder # recursively set permissions to 755
```

--

**Making a script executable**:

```sh
$ chmod +x script.sh
$ ./script.sh
```

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="500"></iframe>

---

## Changing File Ownership

- `chown`: Command to change the owner of a file or directory.
- **syntax**: `chown [options] user:group file`

```sh
$ chown user:group file # change owner and group
$ chown user file # change owner
$ chown :group file # change group
```

Note:
Sometimes you may need to change the owner of a file or directory. This can be done using the `chown` command.

--

### Changing Ownership Recursively

- `chown -R`: Change the ownership of a directory and its contents.

```sh
$ chown -R user:group folder
```

--

### Ownership vs Permissions

- Ownership: Who owns the file or directory.
- Permissions: Who can read, write, or execute the file or directory.

Just because you own a file doesn't mean you write or execute it, for example.

---

# Networking Basics

---

## IP Addresses

Unique identifiers for devices on a network.

- **IPv4**: 32-bit address (e.g., 192.168.1.1)
- **IPv6**: 128-bit address (e.g., 2001:0db8:85a3:0000:0000:8a2e:0370:7334)

Note:
IP addresses are essential for network communication. Each device on a network has an IP address that allows it to send and receive data. IP addresses can be either IPv4 (e.g., 192.168.1.1) or IPv6 (e.g., 2001:0db8:85a3::8a2e:0370:7334). Quick ways to check your IP address include:

--

### Checking Your IP Address

- `ip a` (or `ip addr`): Show IP addresses for all network interfaces.

```sh
$ ip a
$ ip addr | grep inet
```

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="500"></iframe>

--

### Ping

- `ping`: Command to test network connectivity.

```sh
$ ping google.com
```

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="500"></iframe>

Note:
The `ping` command is used to test network connectivity. It sends a series of packets to a remote host and waits for a response. If the host responds, it means that the network connection is working. If the host does not respond, it could be due to a network issue or the host being down.

--

### HTTP Requests

HTTP (Hypertext Transfer Protocol) is the protocol used to transfer data over the web. You can use:

- `curl`: Command-line tool to transfer data with URLs.
- `wget`: Command-line tool to retrieve files from the web.

--

### `curl`

- `curl`: Command to transfer data with URLs.

```sh
$ curl https://example.com
$ curl -o output.html https://example.com
$ curl -O https://example.com/file.txt
```
- `-o`: Save output to a file.
- `-O`: Save output to the filename in the URL.

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="500"></iframe>

--

### `wget`

- `wget`: Command to retrieve files from the web.

```sh
$ wget https://example.com/file.txt
$ wget -O output.txt https://example.com/file.txt
$ wget -q https://example.com/file.txt
$ wget -c https://example.com/file.txt
```

- `-O`: Change the output filename.
- `-q`: Quiet mode (no output).
- `-c`: Continue a partial download.

--


<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="800"></iframe>

---

# Summary
1. User accounts: Managing users and groups.
2. File permissions: Setting permissions for files and directories.
3. Networking basics: IP addresses, ping, and HTTP requests.
