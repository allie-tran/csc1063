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

**Week 3: Redirection and Pipes**

---

## Today's Agenda

1. Standard Input, Output, and Error
2. I/O Redirection: `>`, `>>`, `<`
3. Pipes: `|`

---

## Last Week Recap

- **Basic System Management**:
    - Package management, disk usage, configurations.
- **File Handling**:
    - Downloading, searching, opening, editing, outputting files.
- **Scripting Basics**:
    - Shell scripts, running scripts, comments, adding scripts to PATH.

---

## Standard Input and Output (I/O)

--

### Week 1 Recap


- **Terminal**: a text-based interface to the system.
- **Shell**:
    - reads commands from the terminal
    - creates a new **process** to run the command
    - initialises the environment
    - executes the command *and waits* for it to finish
    - returns the control to the user (prompt for the next command)

--

### No Terminal

Most shell scripts are run *without a terminal*.
**Examples**:
- Scripts run by the system scheduler.
- Scripts run by other scripts.

When you upload a script to _Einstein_, your script is run by the testing script in the server.

--

### Standard I/O Streams

Almost every **process** has three input/output (I/O) streams:

Name | Symbol | Description
--- | --- | ---
Standard Input | `stdin` | The process reads input from this stream.
Standard Output | `stdout` | The process writes output to this stream.
Standard Error | `stderr` | If the process encounters an error, it writes to this stream.
--

By default, these streams are connected to the terminal.
- `stdin` reads from the what you type.
- `stdout` and `stderr` write to the terminal.

![Figure: Standard I/O Streams](/Images/FigStdIO1.png)

--

### Example: input from `stdin`

Normally you rarely see `stdin` in the commands we learned so far.

We used `cat` to read the content of a file, but without an argument, it reads from `stdin`.

```sh
$ cat[]
You can type anything here and press Enter
You can type anything here and press Enter
```

Here, `cat` just repeats what you type.

--

### Example: input from `stdin` (cont.)

Another example is the `read` command.
```sh
$ read -p "Enter your name: " name
Enter your name: Allie
```

Here, `read` reads the input from `stdin` and stores it in the variable `name`.
- `stdin`: "Allie"

--

### Example: output to `stdout`

```sh
$ echo "Hello, World!"
Hello, World!
```

Here, `echo` writes the output to `stdout`.
- `stdout`: "Hello, World!"

--

### Example: output to `stderr`

```sh[]
$ cat file.txt
Here is the content of the file.
$ cat /this/file/does/not/exist
cat: /this/file/does/not/exist: No such file or directory
```

The first command writes the content of the file to `stdout`.
The second command writes an error message to `stderr`.

For the second command:
- `stdout`: **empty**
- `stderr`: "cat: /this/file/does/not/exist: No such file or directory"

--

### More on `stderr`

- In the terminal, it is not clearly separated from `stdout`.
- But it is important to remember, they are **separate** streams.
- If a script runs successfully, `stderr` is usually empty.

--

### Recap on Standard I/O

- `stdin`, `stdout`, and `stderr` are separate streams, and do not have to be attached to the terminal.
- You can attach them to:
    - Files
    - Devices (e.g., printers, sound cards)
    - Network connections
    - Other processes
- A process _does not care_ where the streams are attached to.

--

### Why?

- **Flexibility**: You can attach the streams to different places.
- **Reusability**: You can use the same script in different contexts.
- **Automation**: You can run scripts without human intervention.
- **Debugging**: You can separate error messages from the output.

---

## I/O Redirection

You can **change** where the standard I/O streams are attached to using **redirection**.

--

### Redirecting Output

- `>`: Redirects `stdout` to a file.
- `>>`: Appends `stdout` to a file.

-

#### Example: `echo`

- `echo` writes to `stdout` always.
- with `>`, the `stdout` is written to the file (so you can't see it in the terminal).
- with `>>`, the `stdout` is appended to the file without overwriting it.

```sh
$ echo "Hello, World!" > hello.txt
$ cat hello.txt
Hello, World!
$ echo "Goodbye, World!" >> hello.txt
$ cat hello.txt
Hello, World!
Goodbye, World!
```

--

#### More examples

```sh
$ cat file.txt > file2.txt # copy file.txt to file2.txt
$ cat file.txt >> files.txt # append file.txt to files.txt
$ ls -l > files.txt # list files in the directory and save to files.txt
$ find files -type f -empty > empty_files.txt # find empty files and save to empty_files.txt
```

Any command that writes to `stdout` can be redirected.

--

#### Caution with `>`

- If the file already exists, `>` will **overwrite** it (old content is lost). Be careful!
- If you want to append (add to the end), use `>>`.
- A note on `>>`: if the file does not exist, it will be created.

--

### Redirecting Input

- `<`: Redirects `stdin` from a file.

--

#### Example: `cat`

Remember `cat` reads from `stdin` if no file is given, and repeats `stdin` to `stdout`.

```sh
$ cat < hello.txt # using stdin from hello.txt
Hello, World!
Goodbye, World!
```

--

### Redirecting Error

It is less common and has a different syntax: `2>`.

```sh
$ cat /this/file/does/not/exist 2> error.txt
$ find files -type f -empty 2> error.log
```

The `stdout` is still written to the terminal, but the `stderr` is written to the file.

--

### Combining Redirections

You can combine redirections.

```sh
$ ls -l > files.txt 2> errors.log # list files and save to files.txt, errors to errors.log
$ ls -l > files.txt 2>&1 # output both stdout and stderr to files.txt
```

- `2>&1` means "redirect `stderr` to the same place as `stdout`" (must come after `>`).

---

## Pipes

You can attach the `stdout` of one command to the `stdin` of another command using **pipes**.

--

### Syntax

```sh
command1 | command2
```

`|` is the pipe symbol. It connects the `stdout` of `command1` to the `stdin` of `command2`.

--

### Why Pipes?

- Some tasks require multiple commands.
- You can combine commands without creating temporary files.
    - No extra disk space used.
    - No accidental overwriting of files.
    - No tidying up after the commands.

--

### Example: Counting Lines

+ **Scenario**: You want to count the number of lines in a file that contain the word "error".

```sh
$ grep error file.txt | wc -l
23
```

- `grep error file.txt` finds lines with "error" and writes them to `stdout1`.
- `wc -l` counts the lines from `stdin2` (which is `stdout1`).

--

## Non-blocking Pipes

Sometimes pipes can produce output before the first command finishes.
It means the second command can start as soon as the first command produces **some** output.
This is called **non-blocking** pipes: `cat`, `grep`, `head`, `tail`, etc.

```sh
$ cat file.txt | grep "your search"
$ tail -f /var/log/syslog | grep error
```
If `cat` reads the first line, `grep` can start searching it without waiting for `cat` to finish reading the whole file.

`tail` command does not finish until you stop it (e.g., with `Ctrl+C`), so it can keep sending lines to `grep`.

--

### Blocking Pipes

Some commands need to read the whole input before producing any output.
For example, `sort`, `uniq`, `wc`, etc.

```sh
$ cat file.txt | sort
$ cat file.txt | uniq | wc -l
```

Because it does not make sense to sort the lines before reading all of them. Same for `uniq` and `wc`.

--

### Notes

Some command can be both blocking and non-blocking, depending on the options you use.

---

## Summary
