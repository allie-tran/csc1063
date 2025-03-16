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
**Week 5: Variables, Command-Line Arguments and Iterating**

---

## Solutions
[Lab Solutions](https://csc1063.computing.dcu.ie/einstein/solutions.html)

---

## Today's Agenda
1) Shell Variables
2) Reading Variables
3) Command-Line Arguments
4) Iteration

Note:
Variables – “Making the Shell Remember Things”
“Imagine you’re writing a script, and you want to reuse a filename multiple times without typing it again. That’s where variables come in. Instead of repeating ‘my_file.txt’ ten times, you store it in a variable and use it anywhere.”

Command-Line Arguments – “Making Scripts Flexible”
“What if your script needs different inputs every time? Instead of editing your script every time, command-line arguments allow you to pass values when you run the script—just like how ‘ls -l’ shows a detailed list while ‘ls’ alone does not.”

Iteration – “Doing Things Multiple Times Automatically”
“Ever had to rename 100 files or process multiple logs? A for loop can handle this in seconds. Instead of writing 100 commands, you write one smart loop.

---

## Shell Variables

A variable is a symbolic name for a memory location containing a value.

Note:
Before we start using variables in the shell, let’s define what a variable is.
A variable is a placeholder for information that we can reuse in our scripts. Instead of typing the same value multiple times, we store it in a variable and reference it when needed.

--

Instead of writing:

```bash
echo "Hello, John"
echo "Goodbye, John"
```

We can store "John" in a variable and reuse it:

```bash
name="John"
echo "Hello, $name"
echo "Goodbye, $name"
```

Note:
This is useful when writing longer scripts that need to handle changing data.

--

### Assignments

Three ways to assign values to variables today:
1. Direct assignment using the **=** operator. (Week 2)
2. Reading data from standard input (or redirected input using **<**).
3. Command-line arguments.

---

## Recap: Direct Assignment

[Vevox - Recap](https://dcu.vevox.com/#/present/707814)

--

Examples:
```bash
today="Monday"
tomorrow="Tuesday"

pdf="document.pdf"
```

These define three variables -- **today**, **tomorrow** and **pdf** -- and assign a value to each.
<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="200"></iframe>

--

[Vevox - Using variables](https://dcu.vevox.com/#/present/707814)

--

#### Using variables

Examples:


    echo "Today is $today."
    echo "And tomorrow it will be $tomorrow."

    touch "$pdf"


To use a variable's value, we prepend a dollar sign: *$*.

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="200"></iframe>

--

### Notes

- There are no integer variables or the like, just text.
- Use double quotes around the variable name to avoid problems with spaces and special characters.

--

### Notes
It is possible to create shell variables whose values are empty as follows (these are equivalent):

    empty=
    empty=""


---

### Environment Variables

Environment variables are variables that are available to all programs running in the shell.

```bash
echo $HOME
echo $USER
echo $EDITOR
```

Note:
If you open a terminal and type `echo $HOME`, you will see the path to your home directory. This is an example of an environment variable.
These are examples of environment variables that are available to all programs running in the shell.
Unlike shell variables, which are local to the shell (meaning they are lost when the shell exits or a new shell is started), environment variables are inherited by child processes.
Here are some common environment variables

--

#### Common Environment Variables

- **HOME**: the user's home directory.
- **USER**: the user's username.
- **EDITOR**: the user's preferred text editor.
- **PATH**: a list of directories to search for executable files.
- **PWD**: the current working directory.

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="300"></iframe>

--

### Setting Environment Variables

```bash
export MYVAR="hello"
```

Note:
To set an environment variable, use the **export** command.
Conventionally, environment variables are written in uppercase.


--

### Reading Environment Variables

The most basic way:
```bash
echo $MYVAR
```

Other commands:

- `env`: lists all environment variables.
- `printenv`: lists all environment variables.
- `printenv MYVAR`: prints the value of MYVAR.


--

Examples: difference between shell and environment variables

Consider a file *envs.sh*:
```bash
!#/bin/sh
echo $shell_var
echo $ENV_VAR
```

when we run these in the terminal:
```bash
shell_var="shell"
export ENV_VAR="environment"
sh envs.sh
```
only the second line will print "environment".


Note:
The first line will print nothing because the variable is not exported.

---

## Reading Variables
From standard input or redirected input.

Note:
We have seen how to set variables by assigning values to them.

```shell
name="allie"
```
--

### The **read** command

The **read** command reads exactly _one line_ from its standard input and
assigns the tokens of that line to one or more variables.

Note:
The read command is useful for getting input from users or from another command. This is commonly used in interactive scripts where we ask the user for input.

--

**Example: Asking the User for Their Name**

```bash
echo "What is your name?"
read user_name
echo "Hello, $user_name!"
```


How it works:

-	`read user_name` waits for the user to type something.
-	When they press Enter, their input is stored in $user_name.

--

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="500"></iframe>

--

### Multiple tokens

```bash
# standard input: csc1063 allie hello.sh

echo "Enter module, lecturer and task:"
read line
echo "$line"             # csc1063 allie hello.sh
```

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="500"></iframe>

Note:
The read command reads exactly one line from its standard input and assigns the tokens of that line to one or more variables.

--

Each token is assigned to each variable in turn
```bash
# standard input: csc1063 allie hello.sh
read module lecturer task

echo "$module"           # csc1063
echo "$lecturer"         # allie
echo "$task"             # hello.sh
```

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="500"></iframe>

Note:
When there are multiple variables, each token is assigned to each variable in turn.

--

Except for the last variable, to which *all of the remaining tokens* are assigned.
```bash
read module others

echo "$module"           # csc1063
echo "$others"           # allie hello.sh
```

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="500"></iframe>

Note:

What Happens With Extra Words?
If the input has more words than variables, the last variable collects everything left.

--

### Default Separator

The default separator is whitespace.
Consider the following example of the **/etc/passwd** file:

```
root:xx:0:0:root:/root:/bin/bash
bin:xx:1:1:bin:/bin:/sbin/nologin
daemon:xx:2:2:daemon:/sbin:/sbin/nologin
```

--

Change the separator with the **IFS** variable:

```bash
IFS=: read name passwd uid gid group shell < /etc/passwd
# name=root, passwd=xx, uid=0, gid=0, group=root, shell=/bin/bash
```

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="500"></iframe>

**IFS**: *input field separator*

--


[Vevox - Read](https://dcu.vevox.com/#/present/707814)

---

## Command-Line Arguments

--

A command's syntax:

```bash
command_name [arguments]
```

Note:
Most shell commands take arguments. For example, the **ls** command takes a directory name as an argument.

--

Consider the following:

    cut -d ";" -f 3 file1.txt file2.txt

-  The command is *cut*.
-  The command-line arguments are *-d*, *";"*, *-f*, *3*, *file1.txt* and *file2.txt*.

Note:
Similarly, we can pass arguments to scripts.

--

### Using command-line arguments in scripts

Example script *greet.sh*:

```bash
#!/bin/sh
echo "Hello, $1!"
```

Run the script with an argument:

```bash
$ sh greet.sh Allie
Hello, Allie!
```

--> `$1` is a special variable that contains the first command-line argument, which is "Allie" in this case.

--

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="1000"></iframe>

--

### More than one argument

Say we have a shell script name *my-script.sh*.
And say we call our script like this:

```shell
sh my-script.sh john paul george ringo
```

There are four command-line arguments: *john*, *paul*, *george* and *ringo*.


--

So, we can use _\$1_, _\$2_, _\$3_ and _\$4_ to refer to these arguments.

```bash
# sh my-script.sh john paul george ringo

echo "goodbye $1"          # goodbye john
echo "hello $2"            # hello paul
echo "goodbye $3"          # goodbye george
echo "hello $4"            # hello ringo

echo "$1, $2, $3 and $4"   # john, paul george and ringo

touch "$1.txt"             # creates a file named john.txt
grep "$1" artists.txt      # search for john in the file artists.txt
```
--

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="1000"></iframe>

---

## Two more special variables

- **$0** is the name of the script itself.
- **$#** is the number of command-line arguments.

--

### Example script *example-0.sh*:

    #!/bin/sh
    echo "$0"

Example invocations:

```bash
sh example-0.sh
# prints example-0.sh to standard output
```
--

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="1000"></iframe>

--

### Example script *example-1.sh*:

    #!/bin/sh
    echo "$#"

Example invocations:
```bash
sh example-1.sh a b c         # prints 3 to standard output
sh example-1.sh a b c d       # prints 4 to standard output
sh example-1.sh               # prints 0 to standard output
```

--

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="1000"></iframe>

--

### Example script *example-2.sh*:

    #!/bin/sh
    grep -v -i "$@"

Example invocations:
```bash
sh example-2.sh pdf files.txt
# runs grep -v -i pdf files.txt
```

--

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="1000"></iframe>

--

## More special shell variables

Read the lecture notes for more information.

---

## Quotes

We have seen the use of quotes in the following examples:

    cat "$@"
    cut -d ':' -f 6 /etc/passwd

Both double quotes and single quotes are used to group characters together.
What is the difference?

--

### Friendly reminder:
Special characters are characters that have a special meaning to the shell.
For example, **$**, **>**, **<**, **|**, **&**, **;** and so on.

→ Quotes are used to suppress the special meaning of special characters.

--

### Example Problem

Wrong way:
```bash
$ file=My Document.txt
commmand not found: Document.txt
$ mkdir Fish&Chips
```

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="500"></iframe>

--

Correct way:
```bash
$ file="My Document.txt"
$ mkdir "Fish&Chips"
```
--

### Single Quotes and Double Quotes

- Single quotes are used to suppress the special meaning of *all* characters.
- Double quotes are used to suppress the special meaning of *all* characters *except* for:
    - $: variable expansion
    - \`: command substitution
    - \\ : escape character
    - !: history expansion
    - ": double quotes

--

So, to see the difference, try:

    x='hello'

    echo "> $x John"
    # outputs "> hello john"

    echo '> $x John'
    # outputs "> $x john", so, the variable is not expanded

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="500"></iframe>

---

## Iterating

Note:
Quite often, we need to do the same thing for each item in a list.
Examples:
-  Create a file for each command-line argument.
-  Run a command for each file in a directory.
-  Print a message for each day of the week.

We can use a **for** loop to iterate over a list of tokens.

---

## The **for** Loop

```bash
for arg in one two three
do
    echo "$arg"
done

# outputs:
one
two
three
```

-  The **for** command is followed by a variable name (_arg_ in this case),
    the word **in**, and a list of tokens.
-  The variable name (_arg_) is assigned the value of each token in turn.

--

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="1000"></iframe>

--

Common use case: do the same thing for each command-line argument.

- **$@** is a special variable that contains all the command-line arguments.

```bash
#!/bin/sh

# Create a file for each command-line argument.
for arg in "$@"
do
    touch "$arg"
done
```

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="500"></iframe>

--

```bash
#!/bin/sh

# Create a file for each command-line argument.
for arg in "$@"
do
    touch "$arg"
done
```

### Notes
- _arg_ can be any name you like.
- The commands between **do** and **done** can be any non-empty sequence of shell commands or pipelines.
- The commands are usually indented for clarity, but this is not required.

--

## More on For Loops

```bash
for day in monday tuesday wednesday thursday friday
do
    echo "$day is a working day :("
done
```

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="500"></iframe>

--

Another example
```bash
#!/bin/sh

for count in 10 9 8 7 6 5 4 3 2 1
do
   echo "$count"
   sleep 1
done
```

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="500"></iframe>

--

*With wildcards*

Instead of copying files one by one, we can use a loop.

```bash
for file in *.txt
do
    echo "Backup $file"
    cp "$file" "backup/$file"
done
```

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="500"></iframe>

--

With `seq`:
*seq* is a command that generates a sequence of numbers.

Syntax: `seq last`, `seq first last`, `seq first increment last`

```bash
seq 10
# outputs: 1 2 3 4 5 6 7 8 9 10
seq 2 5
# outputs: 2 3 4 5
seq 10 -2 0
# outputs: 10 8 6 4 2 0
```

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="500"></iframe>


--

```bash
for count in $(seq 5 -1 1)
do
   echo "$count"
   sleep 1
done
echo "See you on Wednesday!"
```

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="500"></iframe>

---

### Summary

- Variables store reusable values.
- Use **read** for user input and understand tokenization.
- Command-line arguments (`$$1`,`$@`, `$#`) allow flexible scripting.
- Quotes prevent unexpected issues.
- **For** loops automate repetitive tasks.
