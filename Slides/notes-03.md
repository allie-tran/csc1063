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

**Week 3: Input/Output Redirection and Pipes**

---

## Today's Agenda

1. Standard Input, Output, and Error
2. I/O Redirection: `>`, `>>`, `<`
3. Pipes: `|` - connecting commands

---

## Last Week Recap
1) Getting help with commands: `man`, `help`, `--help`, `whatis`
2) Text files: viewing, and editing with `cat`, `less` and `nano`
3) Writing shell scripts

--

[Vevox](https://dcu.vevox.com/#/present/700610)

---

## Standard Input and Output (I/O)

--

### Week 1 Recap


**Terminal**: a text-based interface to the system.

> Most shell scripts are run *without a terminal*.

Example:
When you upload a script to _Einstein_, your script is run by the testing script in the server.


Note:
We have talked about the shell reading commands typed at
the terminal, running those commands, and printing their output to the
terminal.

This is a simplification.
In fact, what is happening is considerably more general purpose.
Most shell scripts are run
without being attached to a terminal at all.  For example, when you upload
your lab work to _Einstein_ it is tested on a server with no
keyboard or monitor attached.  Yet your scripts run just fine.

Here, is the full explanation of what is happening...

--

### Shell and Processes

When you run a command (in the terminal or in a script): [Vevox](https://dcu.vevox.com/#/present/700610)

+ **The shell** reads the command,
+ creates a new **process** to run the command,
+ initialises the environment,
+ executes the command *and waits* for it to **exit** (finish),
+ move on to the next command


---

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

Note:
When the shell is run in a terminal, all three of these streams are (by
default) attached to the terminal.  So, whatever you type into the terminal
appears on standard input for the shell process.  And, whatever the shell
process writes to standard output appears on the terminal.  And similarly
for standard error.

--

### Example: input from `stdin`

Normally you rarely see `stdin` in the commands we learned so far.

We used `cat` to read the content of a file, but without an argument, it reads from `stdin`.

```sh[]
$ cat
```

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="500"></iframe>

Here, `cat` just repeats what you type.

--

### Example: input from `stdin` (cont.)

Another example is the `read` command.
```sh
$ read -p "Enter your name: " name
Enter your name: Allie
```

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="500"></iframe>

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

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="500"></iframe>

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

### The Key Point

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

Note:
Thus, the idea of standard input and output being a separate concept from
the terminal itself is a very powerful one.  It allows you to write shell
scripts which can be re-used in substantially different contexts, and they
just work.

When you upload your lab work to the class web site, your
scripts are run in an environment where standard input and standard output
are attached to files, and _Einstein_ verifies that your scripts
produce the expected output.  But -- when writing and testing your scripts
-- you don't need to be concerned with that, because it just works.


---

## I/O Redirection

You can **change** where the standard I/O streams are attached to using **redirection**.

--

### Redirecting Output

- `>`: Redirects `stdout` to a file.
- `>>`: Appends `stdout` to a file.

--

#### Example: `echo`

- `echo` writes to `stdout` always.
- with `>`, the `stdout` is written to the file (so you can't see it in the terminal).

```sh
$ echo "Hello, World!" > hello.txt
$ cat hello.txt
Hello, World!
```

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="500"></iframe>

--


with `>>`, the `stdout` is appended to the file without overwriting it.

```sh
$ echo "Goodbye, World!" >> hello.txt
$ cat hello.txt
Hello, World!
Goodbye, World!
```
<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="500"></iframe>

--

#### More examples

```sh[1-2|3-4|5-6|7-8]
# copy file.txt to file2.txt
$ cat file.txt > file2.txt
# append file.txt to files.txt
$ cat file.txt >> files.txt 
# list files in the directory and save to files.txt
$ ls -l > files.txt 
# find empty files and save to empty_files.txt
$ find files -type f -empty > empty_files.txt
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

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="500"></iframe>

--

### Redirecting Error

It is less common and has a different syntax: `2>`.

```sh
$ cat /this/file/does/not/exist 2> error.txt
$ find files -type f -empty 2> error.log
```

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="500"></iframe>

The `stdout` is still written to the terminal, but the `stderr` is written to the file.

--

### Combining Redirections

You can combine redirections.

```sh
# list files and save to files.txt, errors to errors.log
$ ls -l > files.txt 2> errors.log
# output both stdout and stderr to files.txt
$ ls -l > files.txt 2>&1
```

 `2>&1` means "redirect `stderr` to the same place as `stdout`" (must come after `>`).

--

[Vevox](https://dcu.vevox.com/#/present/700610)

--

### Summary

- `>`: Redirect `stdout` to a file.
- `>>`: Append `stdout` to a file.
- `<`: Redirect `stdin` from a file.
- `2>`: Redirect `stderr` to a file.

Note:

We learned that standard input and
output are very general concepts.  A process doesn't necessarily know where
its input is coming from (a terminal? a file?) or where its output is going
to.  It simply reads standard input and writes standard output.  And, with
``<`` and ``>``, we can redirect standard input and output from/to files.

The next question is:
What if we could arrange for the standard output of one process to be
connected _directly_ to the standard input of another?

Alternatively, what if we could connect sequences of commands in a way
which avoids the need for temporary files?

---

## Pipes

You can attach the `stdout` of one command to the `stdin` of another command using **pipes**.

Note:
In shell programming (and the operating system), a _pipe_ is a mechanism for directly connecting the
standard output of one process to the standard input of another.

--

### Example: `wc`

`wc` is a command that counts the number of lines, words, and characters in a file.

```sh[1-2|3-4]
$ wc file.txt
  23  100  500 file.txt
$ wc -l file.txt # count only lines
    23 file.txt
```
<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="500"></iframe>

--

> Task: Count the number of lines containing the word "lamb" in a file `mary.txt`.

Any solution?

--

1. Extract the lines containing "lamb" using `grep`.
2. Count the lines using `wc`.

--

### Solution: Using a temporary file

```sh[3|4]
#!/bin/sh

grep lamb mary.txt > temp.txt
wc -l temp.txt
```

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="500"></iframe>

--

### Solution: Using Pipes

```sh
#!/bin/sh

grep lamb mary.txt | wc -l
```

The pipe replaces the temporary file.

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="500"></iframe>

Note:
The key point here is the vertical bar symbol.  This is known as a "pipe".
On a keyboard, it's usually near the bottom left.

Just like ``<`` and ``>``, the pipe symbol has a special meaning to the
shell.  Whenever the shell encounters the pipe symbol, it arranges that a process is created for the command on the left and another for the command on the right,
_and
that the standard output of the former is passed as the standard input to
the latter_.
In the example above, the *only* output will be a number.  The standard
output of *grep* is consumed as the standard input to *wc*;
_no_ temporary files are required.

--

### Illustration
```
 --------            -------
 | grep | stdout     | wc  | stdout
 |      | ---------> |     | ------------>
 |      |      stdin |     |   The output will be
 |      |            |     |   a single number.
 --------            -------
 ```

--

### Syntax

```sh
command1 | command2
```

- `|` is the pipe symbol.
 - It connects the `stdout` of `command1` to the `stdin` of `command2`.

--

### Why Pipes?

- Some tasks require multiple commands.
- You can combine commands without creating temporary files.
    - No extra disk space used.
    - No accidental overwriting of files.
    - No tidying up after the commands.

Note:
. No need for extra disk space (and, correspondingly, no disk bandwidth is consumed).
. No possibility of a file-name clash +
  (e.g., with temporary files, two processes might inadvertently use the same name for a temporary file at the same time -- oops!).
. No need to tidy up temporary files after use.
. Pipelines can (often) begin producing output before all of the input has been consumed +
  (see immediately below).
. The syntax is clearer and more concise.

In general, you should always avoid using temporary files when a suitable
solution using a pipeline is available.

--

> Task: Count the number of files in the current directory.
```sh
$ ls | wc -l
```

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="500"></iframe>

Note:
This is a simple example, but it shows the power of pipes.  The output of
``ls`` is a list of files in the current directory.  The output of ``wc -l``

--

> Task: Find the number of empty files in or under the current directory.

```sh
$ find . -type f -empty | wc -l
```

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="500"></iframe>

--

> Task: view a long output of a command one page at a time.

For example, `find` command can produce a long list of files, and you want to view it one page at a time with `less`.

```sh
$ find . -type f | less
```

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="500"></iframe>

--

> Task: Search for a word in a file and view the lines containing the word.

```sh
$ grep "your search" file.txt | less
```
<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="500"></iframe>

--

## Blocking and Non-blocking Pipes

- **Blocking Pipes** wait until all the input has been processed before producing output.
- **Non-blocking Pipes** process data as it comes in, without waiting for all the input to finish.

--

### Blocking Pipes

Blocking pipes wait until all the input has been processed before producing output.

```sh
$ cat file.txt | wc -l
```

- `cat` reads the whole file and writes to `stdout`.
- `wc` **waits** until `cat` finishes sending the output.
- Once `cat` finishes, `wc` starts counting the lines.

--

### Non-blocking Pipes

Non-blocking pipes process data as it comes in, without waiting for all the input to finish.


```sh
find /etc -name "*.conf" | grep "network"
```

- `find` searches for files ending in `.conf` in `/etc`.
- It sends filenames to `grep` one by one, as soon as they’re found.
- `grep` processes each filename immediately without waiting for `find` to finish.

--

```sh
find /etc -name "*.conf" | less
```

`less` starts displaying the output as soon as `find` starts sending it.

--

```sh
ps aux | grep "root"
```

`ps` sends the list of processes to `grep` one by one

--

### Notes

Some command can be both blocking and non-blocking, depending on the options you use.

---

## Summary

1. Standard I/O streams: `stdin`, `stdout`, and `stderr`.
2. I/O redirection: `>`, `>>`, `<`, `2>`.
3. Pipes: `|` connects the `stdout` of one command to the `stdin` of another.
