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

**Week 6:** Substitutions, Exit Status, and Conditionals

---

# Agenda
1. Expansion and Substitution
2. **if** Statements
3. Exit Status
4. The **test** Command
5. Conditional Execution

Note:
The first is the extension of the previous week's topic (variables)
And the rest of the lecture will focus on how to control the flow of a shell script using conditionals, to write if statements, as in, if this condition is true, then do this, else do that.
This requires understanding several concepts, including exit status, the test command, and conditional execution. 

---

## Shell Expansion and Substitution
Expansion and substitution are used to make shell scripts more powerful and flexible.

Note:
When working in a Linux shell, efficiency is key. Whether you’re automating tasks, writing scripts, or simply running commands, the shell provides powerful mechanisms to manipulate and expand text dynamically. The fundamental features that make this possible are shell expansion and substitutions. These techniques allow you to shorten commands, generate complex patterns, and create flexible workflows.

We will demonstrate this using `echo` command.

--

**Example 1: globbing**

```sh
$ echo *
```
<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="200"></iframe>

This command will print all files and directories in the current directory.

Note: 
When you type `echo *` in the shell, the star character (*) is expanded to all files and directories in the current directory before the echo command is executed. This will print a list of all files and directories in the current directory.

The most important thing to remember is that the shell performs expansion before executing the command, replacing the star character with the actual list of files and directories. This process happens automatically and is a powerful feature of shell scripting. It applies to all commands, not just echo, which makes it a fundamental concept to understand.

--

**Example 2: path expansion**

```sh
$ echo D*
$ echo *s
$ echo [[[[:upper:]]]]*
$ echo /usr/*/share
```
<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="200"></iframe>

Note: similar to the star character, other globbing patterns can be used to match specific files or directories. For example:
- `D*` matches all files and directories starting with the letter D.
- `*s` matches all files and directories ending with the letter s.
- `[[:upper:]]*` matches all files and directories starting with an uppercase letter.
- `/usr/*/share` matches all directories named share within the /usr directory.

--

**Example 3: tilde expansion**

```sh
$ echo ~
$ echo ~root
$ echo ~allie
```
<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="200"></iframe>

- It expands the tilde character (~) to the home directory of the specified user.
- If no user is specified, it expands to the home directory of the current user.

Note:
Another useful expansion is tilde expansion, which you might have seen when working with file paths. What actually happens behind the scenes is that the tilde character (~) is expanded to the home directory of the specified user (in the case of ~root or ~allie), or to the home directory of the current user if no user is specified.

--

**Example 4: arithmetic expansion**

```sh
$ echo $((2 + 2))
$ echo $(($((5 + 5)) * 5)) # nested
```
<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="200"></iframe>

Note:
Arithmetic expansion allows you to perform mathematical calculations within a shell script. The syntax is $(()). For example, $(($((5 + 5)) * 5)) calculates the result of 5 + 5, then multiplies that result by 5. This nested arithmetic expansion demonstrates the flexibility and power of shell scripting.


--

|Operator|Description|
|--------|-----------|
|+       |Addition   |
|-       |Subtraction|
|*       |Multiplication|
|/       |Division (integer division)|
|%       |Modulus (remainder)|
|**      |Exponentiation|

Note:
The arithmetic expansion supports common mathematical operators, such as addition (+), subtraction (-), multiplication (*), division (/), modulus (%), and exponentiation (**). These operators can be used to perform various calculations within a shell script.

--

**Example 5: brace expansion**

```sh
$ echo {a,b,c}.txt
$ echo {1..5}
$ echo {01..10}
$ echo {Z..A}
```
<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="200"></iframe>


Note:
Brace expansion is a powerful feature that allows you to generate sequences of text or numbers. For example, {a,b,c}.txt expands to a.txt, b.txt, and c.txt. Similarly, {1..5} generates the sequence 1, 2, 3, 4, 5, while {01..10} generates the sequence 01, 02, 03, ..., 10.

You can also use brace expansion to generate sequences of characters, such as {Z..A} which generates the reverse alphabetical sequence Z, Y, X, ..., A.

--

```sh
for i in {1..5}
do 
    echo "Number $i"
done
```

Note:
This one is particularly useful in for loops, as shown in the last example. The brace expansion generates the sequence 1, 2, 3, 4, 5, which is then used in the for loop to print each number.

--

**Example 6: using brace expansion with commands**

```sh
$ mkdir Photos
$ cd Photos
$ mkdir {2020..2025}-{01..12}
$ ls
```
<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="200"></iframe>

Note:
Brace expansion can be combined with commands to create directories or files in a structured way. In this example, we create directories for each year from 2020 to 2025, with subdirectories for each month from January to December.

--

**Example 7: Parameter Expansion**

```sh
$ echo $USER
$ echo $HOME
$ name="John"
$ echo "Hello, $name"
```

Note:
Parameter expansion allows you to access and manipulate shell variables and environment variables as seen in previous lectures. For example, $USER expands to the current username, $HOME expands to the home directory, and $name is a user-defined variable that can be used in shell scripts.

--

**Example 8: Command Substitution**

```sh
$ echo "Today is $(date)"
$ echo "The current directory is $(pwd)"
$ echo "We have $(ls | wc -l) files in this directory"
```

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="200"></iframe>

Note:
Command substitution allows you to run commands within a shell script and use the output as part of another command. For example, $(date) runs the date command to display the current date and time, $(pwd) displays the current working directory, and $(ls | wc -l) counts the number of files in the current directory. This feature enables you to dynamically generate content based on the output of commands.

--

You can use the grave accent (\`) to perform a command substitution. The syntax is:

> \`command-name\` or $(command-name)

```sh
$ echo `date -d "last sunday" +%Y-%m-%d`  
$ echo $(date -d "last sunday" +%Y-%m-%d)  
```

Note:
Another way to perform command substitution is by using the grave accent (\`) or the $(command-name) syntax. For example, `date -d "last sunday" +%Y-%m-%d` displays the date of the last Sunday, while $(date -d "last sunday" +%Y-%m-%d) achieves the same result. Both methods allow you to run commands and use their output within a shell script.


--

### Command substitution and shell variables

Store command output to a shell variable using the syntax: _var=$(command-name)_

```sh
$ NOW=$(date)
$ echo "$NOW"
```
Store current working directory name to a variable called CWD:

```sh
CWD=$(pwd)
cd /path/some/where/else
echo "Current dir $(pwd) and now going back to old dir .."

cd $CWD
```

Note:
You can store the output of a command in a shell variable using the syntax var=$(command-name). For example, NOW=$(date) stores the current date and time in the variable NOW, which can then be used in subsequent commands. Similarly, you can store the current working directory in a variable called CWD and use it to navigate back to the original directory after changing directories.

--

### Command substitution and shell loops
Shell loop can use command substitution to get input:

```sh
for f in $(ls /etc/*.conf)
do
   echo "List All Configure Files: $f"
done
```

Note:
Command substitution can be used in shell loops to process the output of commands. In this example, the for loop iterates over all configuration files in the /etc directory using $(ls /etc/*.conf) to get the list of files. The loop then prints each file name using echo. This demonstrates how command substitution can be combined with shell loops to automate tasks and process command output.

---

# Flow Control: **if**

Let's consider a simple example of logic is **pseudocode**:

```python
x = 5
if x = 5 then
    say "x is 5"
else
    say "x is not 5"
```

Note: Logic is a fundamental concept in programming that allows you to make decisions based on conditions. In this example, we have a variable x with a value of 5. The if statement checks if x is equal to 5 and prints a message accordingly. If x is not equal to 5, a different message is printed. This simple logic demonstrates how you can control the flow of a program based on conditions.

--

In shell scripting, we use the **if** command to test conditions.

```sh
x=5
if [ "$x" -eq 5 ]
then
    echo "x is 5"
else
    echo "x is not 5"
fi
```

Note: The above pseudocode can be translated into a shell script using the if command into something like this. The if command tests the condition [ "$x" -eq 5 ] and executes the echo command based on the result. If the condition is true, the message "x is 5" is printed; otherwise, the message "x is not 5" is printed. The fi command marks the end of the if statement.

--

## **if** syntax

```sh
if commmands
then
    commands
fi
```

Or, on a single line:
```sh
if commands; then commands; fi
```

Note: The if command in shell scripting follows a specific syntax. The condition to be tested is placed after the if keyword, followed by the then keyword and the commands to be executed if the condition is true. The fi keyword marks the end of the if statement. The commands can be written on separate lines or combined on a single line using semicolons.

--

**If and Else**

```sh
if commands
then
    commands
else
    commands
fi
```

Note: In more complex scenarios, you can use the else keyword to specify an alternative action if the condition is false. The else keyword is followed by the commands to be executed when the condition is false.

--



**Multiple branches**

```sh
if commands
then
    commands
elif commands
then
    commands
else
    commands
fi
```

Note: 
If you need to test multiple conditions, you can use the elif keyword to add additional branches to the if statement. The elif keyword allows you to test different conditions sequentially, executing the commands associated with the first condition that is true. The else keyword specifies the default action if none of the conditions are met.

Notice how the "conditions" are actually commands that are executed. This is the key difference between shell scripting and other programming languages. What are actually being tested here? We will discuss this in the next section.

---

## What can be used as a condition?

--

### Exit Status

We are creating processes when we run shell commands.

```bash
sleep 5
grep Mary poem.txt
```

This creates a process, and the shell _waits_ until that process exits
before moving on to the next command.

Note:
For example, when you run the sleep 5 command, a process is created that waits for 5 seconds before exiting. Then it moves on to the next command.

--

### Success vs Failure

When **any** process exits, it yields an _exit status_ (also _exit code_).

- If the process succeeded, the exit status is **0**.
- Otherwise, it is a non-zero value (integer), depending on the error.

Note:
When a process exits, it returns an exit status, which is an integer value that indicates whether the process succeeded or failed. If the process succeeded, the exit status is 0. If the process failed, the exit status is a non-zero value that indicates the type of error that occurred. This exit status is crucial for understanding the outcome of a command and controlling the flow of a shell script based on the results.

---

### Get the Exit Status of a command

Variable **$?**: exit status of the last command

```sh[1-2|4-5]
echo "Hello"
echo $?      # 0, the previous command succeeded.

cat /does/not/exist
echo $?      # 1, the previous command failed.
```

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="200"></iframe>

Note:
How do you get the exit status of a command? In shell scripting, you can use the $? variable to access the exit status of the last command that was executed. For example, after running the echo "Hello" command, $? will be 0, indicating that the command succeeded. However, if you run the cat /does/not/exist command, $? will be 1, indicating that the command failed. This exit status provides valuable information about the outcome of a command and can be used to make decisions in a shell script.

--

**`if` condition**

```sh[1-4|6-9]
if echo "Hello"
then
    echo "It worked"
fi

if cat /does/not/exist
then
    echo "How did this happen?"
fi
```

Note:
Coming back to the if statement, the condition to be tested is actually the exit status of the command that goes after the if keyword. Any command or pipeline can be used as a condition, and the if statement will evaluate the **exit status** of that command.

If the exit status is 0 (success), the condition is considered true, and the commands following the then keyword are executed. If the exit status is anything else (failure), the condition is considered false, and the commands following the else keyword (if present) are executed.

--

### **true** and **false** commands

These commands both do _absolutely nothing_:

```bash
true  # This does nothing.
false # And this does nothing either.
```

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="200"></iframe>

But they _do_ set the exit status.
- `true` will always yield `0` (success)
- `false` will always yield `1` (failure)

Note:
Let's demonstrate this with the true and false commands. These commands do nothing but set the exit status. The true command always returns an exit status of 0, indicating success, while the false command always returns an exit status of 1, indicating failure.

It's important to understand that these are **commands** and not actual boolean values. They don't have values like true or false in other programming language, but only return exit statuses of success or failure.

--

**Used in `if` statements**

```sh[1-2|4-5]
$ if true; then echo "It worked"; fi
It worked
$ if false; then echo "It worked"; fi
$
```

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="200"></iframe>

Note:
Here is an example of how the true and false commands can be used in if statements. When the true command is used as the condition, the echo "It worked" command is executed because the exit status is 0, indicating success. However, when the false command is used as the condition, nothing is printed because the exit status is 1, indicating failure.

---

### Exit status of a shell script

Equals the exit status of the _last command_

For example, here's a shell script which _always_ succeeds:

```sh[4]
#!/bin/sh

cat /does/not/exist # <- doesn't matter
true
```

And here's one which _always_ fails:

```sh[4]
#!/bin/sh

true # <- doesn't matter
cat /does/not/exist
```

Note:
The exit status of a shell script is determined by the exit status of the last command that was executed. For example, in the first shell script, the exit status will be 0 because the last command, true, always returns an exit status of 0, indicating success. In the second shell script, the exit status will be 1 because the last command, cat /does/not/exist, returns an exit status of 1, indicating failure.

--

### `exit` command

You can also set the exit status of a script explicitly:

```sh[4]
#!/bin/sh

cat /does/not/exist
exit 1 # <- script failed
true # <- never executed
```

Note:
In addition to the exit status of the last command, you can also set the exit status of a shell script explicitly using the exit command. For example, in this shell script, the exit status is set to 1 using exit 1 after the cat /does/not/exist command, indicating that the script failed. The true command is not executed because the script exits after the exit command.

The exit status of a script is important for error handling and automation, as it allows you to determine the outcome of the script and take appropriate actions based on the result.


---

# Question?
[Vevox](https://dcu.vevox.com/#/present/711473)

---

# The **test** Command

The **test** command is used for testing conditions; for example,
testing whether a file exists or not.

**syntax**

`test EXPRESSION` or `[ EXPRESSION ]`

Note: 
We have seen that we have to use "commands" as conditions in if statements and that the exit status of these commands determines the outcome of the if statement. So, how do we actually test conditions in shell scripting? This is where the test command comes in. The test command is specifically designed for testing conditions and allows you to check various conditions, such as whether a file exists, whether two strings are equal, or whether a number is greater than another number. The syntax of the test command is test EXPRESSION or [ EXPRESSION ], where EXPRESSION is the condition to be tested.

It is interesting to note that both test and [ are actually commands. So there has to be a space after the opening bracket and before the closing bracket.

--

## `test` command

- Produces no output
- Has no side effects
- Only used for the exit status

Note:
The test command is unique in that it produces no output and has no side effects. 
The test command translates the condition into an exit status. If the condition is true, the exit status is 0 (success); if the condition is false, the exit status is 1 (failure).

--

**Examples**
```sh[1|2|4|5|7|8]
test -f /etc/passwd    # Is /etc/passwd a regular file?
test -d ~/Documents    # Is there a directory "Documents" in my home directory?

test -z "$var"         # Is variable "var" empty? ("z" stands for "zero".)
test -n "$var"         # Is variable "var" non-empty?

test "$var" = "Mary"   # Do the contents of variable "var" equal "Mary"?
test "$var" != "Mary"  # Do the contents of variable "var" not equal "Mary"?
```

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="200"></iframe>

---

# Negation: !

This command always succeeds:

```sh
test -d /   #  The root directory always exists.
```

And this command always fails:

```sh
! test -d /
```
<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="200"></iframe>

Note:
The negation operator (!) can be used to reverse the exit status of a command. For example, the test -d / command always succeeds because the root directory always exists. However, when you use ! test -d /, the exit status is reversed, so the command fails. This is a useful technique for checking conditions that are the opposite of what you want.

---

_Any command or pipeline_ can be prefixed with a **!** symbol.

```sh[1|2]
grep -q "Mary" poem.txt    # Succeeds if the text "Mary" is found in "poem.txt".
! grep -q "Mary" poem.txt  # Succeeds if the text "Mary" is not found in "poem.txt".
```

-q option: (quiet) produce no output

_Another example_

```sh[1|2]
test -f ~/.bashrc           # Succeeds if ~/.bashrc is a regular file.
! test -f ~/.bashrc         # Succeeds if ~/.bashrc is not a regular file.
```

Note:
The negation operator (!) can be used with any command or pipeline to reverse the exit status. For example, the grep -q "Mary" poem.txt command succeeds if the text "Mary" is found in the poem.txt file. However, when you use ! grep -q "Mary" poem.txt, the command succeeds if the text "Mary" is not found in the poem.txt file.

Similarly, the test -f ~/.bashrc command succeeds if the ~/.bashrc file is a regular file. When you use ! test -f ~/.bashrc, the command succeeds if the ~/.bashrc file is not a regular file.

---

# `test` Expressions
1. Integer Comparisons
2. String Comparisons
3. File Attribute Checking

Note:
The test command supports various types of expressions for testing conditions. These include integer comparisons, string comparisons, and file attribute checking. Each type of expression allows you to test different conditions and make decisions based on the results.

---

## Integer Comparisions/Conditionals
**syntax**

```sh
test "$num1" Operator "$num2"
[ "$num1" Operator "$num2" ]
```

--

| Operator | Comparison            |
| -------- | --------------------- |
| −lt      | Less than             |
| −le      | Less than or equal    |
| −eq      | Equal                 |
| −ge      | Greater than or equal |
| −gt      | Greater than          |
| −ne      | Not equal             |

--

**Examples with test command**

```sh[3-4|6-7|9-10|12-13]
#!/bin/sh

first_num=99
second_num=100

test "$first_num" -gt "$second_num"
echo "$?"  # 1

test "$first_num" -eq "$second_num"
echo "$?"  # 1

test "$first_num" -lt "$second_num"
echo "$?"  # 0
```

--

**Examples with [ ]**

```sh[1-2|4-5|7-8]
[ "$first_num" -gt "$second_num" ]
echo "$?"  # 1: exit status is 1

[ "$first_num" -eq "$second_num" ]
echo "$?"  # 1: exit status is 1

[ "$first_num" -lt "$second_num" ]
echo "$?"  # 0: exit status is 0
```
--

**Examples with `if` statement**

```sh[1|3-4|5-7|8-15]
int=$1 # Read from command line
if [ "$int" -eq 0]
then
    echo "The integer is zero"
elif [ "$int" -lt 0 ]
then
    echo "The integer is negative"
else
    if [ $((int % 2)) -eq 0 ] # arithmetic expansion
    then
        echo "The integer is even"
    else
        echo "The integer is odd"
    fi
fi
```


---

### String Comparisons/Conditionals

```sh
test "$str1" operator "$str2"
[ "str1" operator "str2" ]
```

--

| Operator   | Comparison                                  |
| ---------- | ------------------------------------------- |
| _s1 = s2_  | used with \[                                |
| _s1 != s2_ | s1 does not match s2                        |
| _s1 \\< s2_ | s1 is smaller than s2 (lexicographically)   |
| _s1 \\> s2_ | s1 is greater than s2 (lexicographically)   |
| _−n s1_    | s1 is not null (has length greater than 0)  |
| _−z s1_    | s1 is null (has length 0)                   |
| _s1_       | s1 is not null (has length greater than 0). |

--

**Example 1**

```sh[3-4|6-7|9-10]
#!/bin/sh

type1="vi"
type2="vim"

test "$type1" = "$type2"   #  or [ "$type1" = "$type2" ]
echo "$?"  # 1

test "$type1" != "$type2" # or [ "$type1" != "$type2" ]
echo "$?"  # 0
```

--

**Lexicographic (greater than, less than) comparison.**

```sh[1-2|3-4]
test "$type1" \> "$type2" # or [ "$type1" \> "$type2" ]
echo "$?"  # 1
test "$type1" \< "$type2" # or [ "$type1" \< "$type2" ]
echo "$?"  # 0
```

--

**Example with `if` statement**

```sh[3|4-8|10-12|13-14|16-17]
#!/bin/sh

answer=$1 # Read from command line
if [ -z "$answer" ]
then
    echo "There is no answer."
    exit 1 # <--- exit status 1
fi

if [ "$answer" = "yes" ]
then
    echo "The answer is yes."
elif [ "$answer" = "no" ]
    echo "The answer is no."
else 
    echo "The answer is not clear."
fi
```
--

### Beware: \\< and \\> tests

```sh[1|2|3]
test 5 \> 2 # 0 (true)
test 5 \< 2 # 1 (false)
test 5 \< 10 # 1 (false??)
```

These are used to compare strings **lexicographically**.

```sh
test 5 -lt 10 # 0 (true)
```

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="200"></iframe>

---

## File Attribute Checking

| Operator        | True if ...                       |
| --------------- | --------------------------------- |
| −e file         | file exists.                      |
| −f file         | file exists and is a regular file |
| −d file         | file exists and is a directory.   |
| -s file         | file exists and is not empty      |

--

| Operator        | True if ...                       |
| --------------- | --------------------------------- |
| file1 -nt file2 | file1 is newer than file2.        |
| file1 -ot file2 | file1 is older than file2.        |
| -r file         | you have read permission on file  |
| -w file         | you have write permission on file |
| −x file         | You have execute permission on    |
|                 | file, or directory search         |
|                 | permission if it is a directory   |
| −O file         | You own file                      |
| -G file         | file's group ID matches yours.    |

--

**Example**

```sh[1-2|3-4|6-7|8-9]
test -f /etc/passwd    # Is /etc/passwd a regular file?
echo "$?"  # 0
test -d ~/Documents    # Is there a directory "Documents" in my home directory?
echo "$?"  # 1

[ -f /etc/passwd ]
echo "$?"  # 0
[ -d ~/Documents]
echo "$?"  # 1
```
--

## With **if** statements

```sh[2|3-7|9-11|12-14|15-17]
#!/bin/sh
file="/etc/passwd"
if ! [ -e "$file" ]
then
    echo "File does not exist"
    exit 1
fi

if [ -f "$file" ]
then
    echo "File is a regular file"
elif [ -d "$file" ]
then
    echo "File is a directory"
else
    echo "File is neither a regular file nor a directory"
fi
```
--

### Questions
[Vevox](https://dcu.vevox.com/#/present/711473)

---

## Logical operators

| Operator   | Description       | syntax                       |
| ---------- | ----------------- | ---------------------------- |
|            |                   |                              |
| !          | logical negation. | !EXPRESSION                  |
| -o or \|\| | logical OR        | EXP1 -o EXP2, EXP1 \|\| EXP2 |
| -a or &&   | logical AND       | EXP1 -a EXP2, EXP1 && EXP2   |
|            |                   |                              |

_Rule of thumb:_ If you use `||` or `&&`, you need to write `[` or `test` again. Not needed if you use `-o` or `-a`

--

**Example**

```sh[3|4|7|8|9]
#!/bin/sh
# Using && and || to combine 2 commands
test -f /etc/passwd && test -d /etc/
[ -f /etc/passwd ] || [ -d does/not/exist ]

# Using -a and -o to combine 2 conditions
[ -f /etc/passwd -a -d /etc/ ]
test -f /etc/passwd -a -d /etc/
[ -f poem1.txt -o -f poem2.txt ] # Is poem1.txt or poem2.txt a regular file?
```

Note:
My personal preference is to use `||` and `&&` because they are more readable. However, you can use `-o` and `-a` if you prefer.

---

## Conditional Sequential Execution

```sh
echo "one"
echo "two"
echo "three"
```

The shell executes the first command, and then the second command, and so on. (This is sequential execution).

-> Commands are separated by **newline character**

--

## The ";" symbol

```sh
echo "one"; echo "two"; echo "three"
```

Less common, but _important_ to notice that _;_ is also a sequential separator.

---

Two other command separators can be used: **&&** and **\|\|**.

```sh
command_1;   command_2;   command_3      # Example 1.
command_1 && command_2 && command_3      # Example 2.
command_1 || command_2 || command_3      # Example 3.
```

Example 1 is just a regular sequential execution.

command_1 -> `wait` -> command_2 -> `wait` -> command_3

--

Examples 2 and 3 are _conditional sequential execution_.

```sh
command_1 && command_2 && command_3      # Example 2.
command_1 || command_2 || command_3      # Example 3.
```

- `&&` (and): command_1 -> wait -> **if succeeded** then command_2, etc.
- `||` (or): command_1 -> wait -> **if failed** then command_2, etc.

--

**Examples**

```sh
# Remove a file, but only if it already exists.
test -f /tmp/document.txt && rm /tmp/document.txt

# Ensure ~/Documents exists.
test -d ~/Documents || mkdir ~/Documents
```

---

### Questions
[Vevox](https://dcu.vevox.com/#/present/711473)

Which command sequence correctly ensures that `echo "Done"` is executed only if `mkdir newFolder` successfully creates a new directory?

```sh
A. mkdir newFolder; echo "Done"
B. mkdir newFolder && echo "Done"
C. mkdir newFolder || echo "Done"
D. mkdir newFolder; echo "Done"
```
--

**What does this do?**

```sh
for arg in "$@"
do
   if [ -f "$arg" ]
   then
      rm "$arg"
   fi

   if ! [ -d "$arg" ]
   then
      mkdir "$arg"
   fi
done
```

---

### Questions
[Vevox](https://dcu.vevox.com/#/present/711473)

---
