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

**Week 8**: `while` Loops and Maths in Shell Scripts

---

# Today's Agenda
1. **while** Loops
2. Maths in Shell Scripts

---

# Group Portfolio
- The deadline for choosing your group is **over**.
- The submission portal is open until **Monday, 7 April** (last lecture).
- The details is on the course webpage.

Note:
If you haven't chosen a group yet, let me know as soon as possible.

---

# **while** Loops

Note:
So in the last lecture we learned about **if** statements. And the week before that we learned about **for** loops.
*while* loops are another type of loop that can be thought of as a combination of both.
It is similar to other programming languages like Python, etc.


---

Define a _condition_ and then loop through a block of code _as long as the condition is true_ (exit `status 0`).

Note:
With a *while* loop, we repeatedly execute a group of commands until a condition is false. In the shell, just as with *if* statements, "a condition is false" means that the command in the condition failed.

---

The structure of a **while** loop is:

```sh
while EXPRESSION
do
   command
   command
done
```

One-liner:

```sh
while EXPRESSION; do command; command; done
```

Note:
The **EXPRESSION** here is a command that returns an exit status of 0 (true) or 1 (false).

--

The tokens **while**, **do** and **done** are required.

Note:
For *if* statements, we used **if**, **then**, **else** and **fi**.
So for *for* loops, we used **for**, **do** and **done**. For *while* loops, we use **while**, **do** and **done**.

--

**Example**

Loop through the numbers 1 to 5.

```sh[3|4|5-9|7]
#!/bin/sh

count=1
while [ $count -le 5 ]
do
    echo "Count: $count"
    count=$(($count + 1)) # <-- Arithmetic expansion
done
```

Note:

Here, the **EXPRESSION** is `[ $count -le 5 ]`, which is the same test we used in the *if* statement.
The **while** loop will continue to execute the commands inside the loop as long as count is less than or equal to 5. And every time the loop runs, the value of count is incremented by 1 by using the arithmetic expansion.

--

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="500"></iframe>

Note:
while-count-down.sh

--

**Example**

Read from standard input until the user quits (Ctrl+D or Ctrl+C).

```sh
while read line
do
   echo $line
done

echo "End"
```

Note:

Here the *read* command will read a line from standard input and assign it to the variable *line*. It only stops when the user sends an EOF signal (Ctrl+D) or an interrupt signal (Ctrl+C).

--

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="500"></iframe>

Note:
while-read-line.sh

--

**Example**

Wait for a file to be created and then print its contents.

```sh
while ! test -f file.txt
do
   sleep 1
done

cat file.txt
```

--

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="500"></iframe>

Note:
while-test-file.sh

So that is the basic structure of a **while** loop. We have seen how to use it to loop through a range of numbers, read from standard input, and wait for a file to be created, essentially keeping the script running until a condition fails.
Next, we will look at more advanced features of **while** loops.

---

## **break** and **continue**

Similar to python, **break** and **continue** can be used in **while** loops.
- **break** will exit the loop.
- **continue** will skip the rest of the loop and go to the next iteration.

--


Example: read from standard input until the user types "quit".

```sh
#!/bin/sh

while read line
do
   echo $line

   if [ "$line" = "quit" ]
   then
      break
   fi
done

echo "Goodbye!"
```

--

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="500"></iframe>

Note:
while-read-break.sh

--

Example: print the numbers from 1 to 5, but skip 3.
```sh
#!/bin/sh
var=0
while [ $var -lt 5 ]
do
    var=$(($var + 1))
    if [ $var -eq 3 ]
    then
        continue
    fi
    echo "$var" # <-- will print 1, 2, 4, 5
done
```

---

## Infinite Loops

An infinite loop is a loop that never ends.

```sh
#!/bin/sh
while true
do
    echo "This is an infinite loop"
done
```

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="500"></iframe>

Note:
Infinite loops are useful for running a script continuously, like a server, or a script that monitors a directory for changes.

However, they can also be dangerous if not handled properly.

In the above example, the script will run forever until it is manually stopped. It is a very common mistake to create an infinite loop by accident.

--

**Example**

```sh
#!/bin/sh
var=0
while [ $var -lt 5 ]
do
    echo $var
done
```
- This will print 0 forever.

---

## Loops and Redirection

**while** loops can be used to read from a file (using `<` redirection).

```sh
#!/bin/sh
while read line
do
    echo $line
done < file.txt
```

`read` command fails when it reaches the end of the file.

--

**Output redirection** can also be used.

```sh
#!/bin/sh
while read line
do
    echo $line
done < file.txt > newfile.txt
```

This will read from `file.txt` and write to `newfile.txt`.

---

## Loops and Pipes

A lab exercise: count the number of arguments passed to a script.

```sh
for arg in $@
do
    echo $arg
done | wc -l
```

--

**while** loops can also be used with **pipes**.

```sh
#!/bin/sh
while read line
do
    echo $line
done < file.txt | wc -l
```

--

Another example: list all files in the current directory.

```
#!/bin/sh

ls | while read line
do
   echo $line
done
```

---

## Fun Fact

We can emulate a **for** loop with a **while** loop.

This:
```sh
for arg in "$@"
do
   # Do something with $arg.
done
```

--

is equivalent to this:

```sh
while [ $# -gt 0 ]
do
   arg="$1"
   # Do something with $arg.
   shift
done
```

Can you work out what **shift** is doing?

---

## Shift Command

--

**shift** downshifts each parameter by **one** by default.
- `$2` becomes `$1`
- `$3` becomes `$2`
- and so on.

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="500"></iframe>

--

#### Shift with a Number

**syntax**

`shift [ num ]`

- **num** is the number of positions to shift.
- If **num** is not specified, it is assumed to be 1 (as in the previous example).

--

**Example**

```sh
#!/bin/sh
echo "The first argument is: $1"
shift 2
echo "The first argument after shift 2 is: $1"
```

--

**Output**

```sh[1|2|3]
> sh shift_example.sh red yellow green
The first argument is: red
The first argument after shift 2 is: green
```

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="500"></iframe>

--

#### Back to the **while** Loop

```sh
while [ $# -gt 0 ]
do
   arg="$1"
   # Do something with $arg.
   shift
done
```

The **shift** command reduces the number of arguments by 1 each time it is executed.
Eventually, the **while** loop will terminate when there are no more arguments.

Note:
This is how we can emulate a **for** loop with a **while** loop.

Each time the loop runs, the first argument is assigned to the variable **arg** and then the arguments are shifted down by one. So the next time the loop runs, the second argument will be $1, and assigned to **arg**. The next time, the third argument will be $1, and so on.

Every time we call **shift**, the number of arguments is reduced by one. Eventually, the loop will terminate when there are no more arguments.

---

## Math in shell scripts

Note:
By default, _all_ bash variables are character strings, unless otherwise specified.
But sometimes we need to perform arithmetic operations in shell scripts.

--

There are different ways to perform integer arithmetic in bash:
  1. _expr_ command
  2. _let_ command
  3. using brackets
  4. arithmetic expansion

---

### Method 1: expr command

```sh
$ expr 5 + 3
8
```

--

**Important**: We must escape the `*` with a backslash.

```sh
$ expr 5 * 2
expr: syntax error
$ expr 5 \* 2
10
```
--

**In a script**

```sh
var1=10
var2=2
var3=$(expr $var1 / $var2) # <-- command substitution
```

--

**It's also picky about spaces.**

```sh
$ expr 5+3
5+3
$ expr 5 + 3
8
```

---

### Method 2: let command

It assigns the result of the arithmetic operation to a variable.
```sh
$ let sum=3+5
$ echo $sum
```

Note:
_let_ is another built-in command to do arithmetic operations in bash, that assigns the result of the arithmetic operation to a variable.

It _can't_ print the output to the terminal without storing the value in a variable.

--

It is also a little picky about spaces, but opposite to `expr` (no spaces)

```sh
$ let sum=3 + 5
let: +: syntax error: operand expected (error token is "+")
$ let sum=3+5
```

--

`let` also relaxes the normal rule of needing a **$** in front of variables to be read.

```sh
$ a=5
$ let b=a+3 # let b=$a+3 is also valid
$ echo $b
```

--

`let` doesn't need the backslash to escape the `*`.

```sh
$ let product=a*b
```

---

### Method 3: Using Brackets

```sh
#!/bin/sh
$ a=5
$ echo $[a + 3] # <- no $ sign needed
8
$ b=$[a * 2] # <- no escape character needed
$ echo $b
10
```

Note:
This is another way to perform arithmetic operations in bash, which is usually used in older scripts. However, it is still valid and works in modern bash scripts.

---


### Method 4: Arithmetic Expansion

**syntax**
`$((arithmetic-expression))`

We can use this to assign the result of an arithmetic expression to a variable.

```sh
##!/bin/sh

a=6
b=3

division=$((a/b))
modulo=$((a%b))

echo "division=$division"
echo "modulo=$modulo"
```

Note: we have learned about arithmetic expansion before when we talked about shell expansion.

--
So a few things to note here:

```sh
$ echo $((5 + 3)), $((5+3)) # <- not picky about spaces
8, 8
$ echo $((5 * 3)) # <- no escape character needed
15
$ a=5
$ echo $((a + 3)) # <- no $ sign needed
```
---

### Limitations

No _floating point_ arithmetic is possible with these methods.

```sh
var1=10
var2=3

var3=$[ $var1 / $var2 ] # brackets
var4=$(expr $var1 / $var2 ) # expr
var5=$(( $var1 / $var2 )) # arithmetic expansion
```

**Output** for all methods: 3


For that you need another shell like _zsh_, or use an external command like _bc_.

---

## BC - Basic Calculator

It is a command-line calculator that can handle floating point numbers.

```sh
$ bc # or bc -q for quiet mode
scale=2
10 / 3
3.33
# comments are allowed
var1=23.5
var2 = var1 * 2
print var2
47
# ...
quit # or Ctrl+D
```
--

**How to use bc in a shell script**

We need to use pipes and command substitution to capture the output of the bc command.

```sh
#!/bin/sh
var1=$(echo "scale=2; 10 / 3" | bc)
echo $var1
3.33
```

<iframe data-src="http://localhost:8080" title="Terminal" width="1920" height="500"></iframe>

--

What it does:
- The `echo` command and the pipe send the expression to the `bc` command.
- The `bc` command evaluates the expression and sends the result to its standard output.
- The command substitution captures the output of the `bc` command and assigns it to the variable `var1`.

Note:
In conclusion, we have seen different ways to perform arithmetic operations in shell scripts. We have also seen that bash does not support floating-point arithmetic, but we can use external commands like `bc` to handle floating-point numbers.

---

# Summary

- **while** loops are used to execute a block of code repeatedly as long as a condition is true.
- **break** and **continue** can be used to control the flow of a loop.
- **shift** command can be used to modify the positional parameters.
- Math operations can be performed using different methods in shell scripts.
