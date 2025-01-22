---
theme: css/dracula.css
highlightTheme: css/rose-pine-moon.css
transition: slide
duration: 1h
classSize: ~102
width: 1920
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

**Week 2: Viewing Files, Text Editors, and Shell Scripts**

---

## Today's Agenda

1) Getting help with commands
2) Text files
3) Shell scripts

---

## Q/A from Last Week

[Feedback + Questions Form](https://loop.dcu.ie/course/view.php?id=68391&section=1)

--

**Group Project**:

- You can choose your own groups [Here](https://loop.dcu.ie/mod/choicegroup/view.php?id=2580811)
- Deadline: Reading Week

--

**Work from Home:**
- I recommend attending the labs for the first few weeks.
- If you have trouble submitting at home, I won't be able to help you.

--

## **Please ask questions!**

---

## Getting Help with Commands

--

`whatis`: one-line description of a command.

--

```sh
$ whatis echo
echo (1)     - display a line of text
```

--

```bash[1-2|4-5]
$ echo hello
hello

$ echo hello, world!
hello, world!
```

--

`help`: a more detailed description

--

```sh
$ help echo
```

--

```sh
$ help echo
```
<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="800"></iframe>

--

```sh
$ echo -n "Hello, "
Hello, $
```

--

`--help`: flag to get help on a command.

--
```sh
$ cat --help
```
--

```sh
$ cat --help
```
<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="800"></iframe>

--

```sh
$ cat file.txt

$ cat -n file.txt

$ cat file1.txt file2.txt
```

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="500"></iframe>

--

`man`: manual pages for commands.

--

```sh
$ man less
```
--

```sh
$ man less
```
<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="800"></iframe>

--

`apropos`: search for commands.


--

```sh
$ apropos copy
```
--
```sh
$ apropos copy
```
<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="800"></iframe>



---

### Help commands
- `whatis`: one-line description of a command.
- `help`: a more detailed description.
- `--help`: flag to get help on a command.
- `man`: manual pages for commands.
- `apropos`: search for commands.

--

### New Commands

```sh[1-2|3-4|5-6]
$ whatis echo
echo (1)     - display a line of text
$ whatis cat
cat (1)      - concatenate files and print on the standard output
$ whatis less
less (1)     - opposite of more
```

---

### More Tips

Use longer paths instead of `cd` multiple times.

```sh[1-3|5]
$ cd ~
$ cd csc1063
$ cd Documents

$ cd ~/csc1063/Documents
```

--

Same with `cp`, `mv`

```sh
$ cp ~/csc1063/Documents/file.txt ~/csc1063/Documents/Backup/

$ cp file.txt ../Backup/

$ cp ../Documents/file.txt ./
```

--

Use  ` Tab `  for auto-completion.

---

## Text Files

--

**Plain Text**

not: Microsoft Word, PDF, etc.

--

Examples:
- Configuration files
- Scripts

--

### Viewing Text File

- `cat`: concatenate and display file contents.
- `less`: view file contents page by page.

--

#### `/etc/passwd`: User Account Information

--

```sh
$ cat /etc/passwd
```
--

```sh
$ cat /etc/passwd
```
<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="800"></iframe>

--

```sh
$ less /etc/passwd
```
--

```sh
$ less /etc/passwd
```
<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="800"></iframe>

---

`grep`: search for text in files.

```sh[1|2]
$ grep <pattern> <filename>
$ grep allie /etc/passwd
```

--
```sh
$ grep allie /etc/passwd
```
<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="800"></iframe>

---

### Text Editors


---

**Graphical Editors**:
+ gedit, kate, vscode

**CLI Editors**:
+ nano, vim, emacs

---

### Nano

- Simple and easy to use.
- Beginner-friendly.

--

```sh
$ nano file.txt
```

--

![Open Nano|1900](https://media.geeksforgeeks.org/wp-content/uploads/20200304140712/cutpaste.gif)

--

### Vim

- Powerful and efficient.
- Steeper learning curve.

--

![POV|1800](https://preview.redd.it/i-have-been-using-vim-for-the-past-2-years-not-because-i-v0-ud43pn6gn52b1.png?auto=webp&s=15ec594a315087222f5ae74b458a8e59a76c0d18)

--

![How to Exit Vim|1900](https://miro.medium.com/v2/resize:fit:652/1*6_ayWFq8lJ-fafpeiafiBg.png)

--

```sh
$ vim file.txt
```

--

To **exit**:

- Press `Esc`
- Type `:q!` (force quit) or `:wq` (write and quit)
- Press `Enter`

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="500"></iframe>

---

## Questions
[Vevox](https://dcu.vevox.com/#/present/696845)

---

## Shell Scripts

Note:
The shell doesn't just run commands interactively. It can also read commands from a file (a **shell script**) and execute them sequentially.

It can be used to automate repetitive tasks, create custom commands, and more.

--

A text file containing a sequence of commands.

--

filename: `hello.sh` (ends with `.sh`)
```sh
#!/bin/sh

# This is a comment
echo hello
```
--

**Running Scripts**:

Use `sh <script filename>`
```sh
$ sh hello.sh
hello
```

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="500"></iframe>

--

**Comments**:
- Lines that are not executed.
- Start with `#`.

`hello.sh`:
```sh[1]
#!/bin/sh

# This is a comment
echo hello # also a comment
```

--

**Shebang Line**:

- The first line of a script.
- Starts with `#!`.
- Tells the system which shell to use.

```sh
#!/bin/sh
```
--

Same language as the shell.

--

A slightly longer script:

`longer.sh`:
```sh[1|3|5-8|9-11|13-14]
#!/bin/sh

cd ~ # Change to the home directory

# Print the current directory
echo "The current directory is:"
pwd

# List the contents of the current directory
echo "The contents of the current directory are:"
ls

# Say goodbye
echo "Goodbye!"
```

--

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="1000"></iframe>

---

## Variables

Store data for later use.

Note:
Similar to other programming languages, we can use **variables** in shell scripts to store values. Let's look at an example:

--

```sh[4|7]
#!/bin/sh

# Assign a value to a variable
name="Allie"

# Print the value of the variable
echo "Hello, $name!"
```

Output: `Hello, Allie!`

--
```sh[4|7]
#!/bin/sh

# Assign a value to a variable
name="Allie"

# Print the value of the variable
echo "Hello, $name!"
```
**Rules**:
+ No spaces around `=`.
+ No ` $ ` when assigning a value.
+ Use ` $ ` to access the value.

--

**Example**:

```sh[4|7|10]
#!/bin/sh

# Assign a value to a variable
to_remove="file.txt"

# Make a backup of the file
cp $to_remove $to_remove.bak

# Remove the file
rm $to_remove
```

--

**Variables** are **text**

```sh
$ number=5
$ number="5"
```

--

**Empty Variables** (unset):

```sh
echo $a_random_variable
```
The output is empty.

--

**Unsetting Variables**:

```sh
$ unset a_random_variable
```

---

# CSC1063: Lab Demo

---


### Configure nano

Open the `.nanorc` file in your home directory.

```sh
$ nano ~/.nanorc
```

--

Add the following lines:

```plaintext
include "/usr/share/nano/*.nanorc"

set linenumbers
set tabsize 4
set tabstospaces
set autoindent
set mouse
```


---

### Searching for Files

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

# Output a list of all the files in csc1063
$ find ~/csc1063 -type f
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

# List all PDF files with certain pattern.
ls -l a[a,b]a.pdf
ls -l a[!c]a.pdf

# Output all lines of all JavaScript files which contain the text "function".
grep function *.js
```

---

### Searching for Text in Files

**The `grep` utility**: Search for text in files.

```sh
$ grep [OPTIONS] PATTERN [FILE...]
```

Where:
- `OPTIONS`: flags to modify the search.
- `PATTERN`: the text to search for.
- `FILE...`: the files to search in.

--

**Examples**:

```sh
# Output all lines from the file "messages.txt" which contain the text "hello".
$ grep hello messages.txt

# Output all lines from the three JavaScript files which contain the text "function".
$ grep function file1.js file2.js file3.js
```

--

**Common Options**:

- `-w`: Match whole words.

```sh
$ grep -w cat file.txt
```

--

- `-i`: Ignore case.

```sh
$ grep -i -w cat file.txt
```

--

### Globbing with `grep`

- `grep` can also use glob patterns.

```sh
$ grep "function" *.js
```
