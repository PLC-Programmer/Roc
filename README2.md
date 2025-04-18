2025-04-18, work in progress

See [solution #1](https://github.com/PLC-Programmer/Roc/blob/main/README.md)

<br/>

# How to make a simple "for-loop" in Roc? -- solution #2

Roc source code: https://github.com/PLC-Programmer/Roc/blob/main/simple_counting_solution_%232.roc

This example heavily leans into this official example: https://www.roc-lang.org/examples/TowersOfHanoi/README.html

..and thus is based on **recursion**, here with a user defined, "pure" function named _int_generate_.

However, to convert the "Towers of Hanoi" example into a simple, recursive function to just count from 0 to 9 (inclusively) had its challenges too.

<br/>

####  #1 -- Be precise with types

First, I noticed - maybe not in this very simple example - that it's really beneficial to be very precise with the data types, for example like this for an unsigned 32-bit integer number:

```
  upper_limit = 10u32
```

Builtin functions or functions from 3rd party libraries may return a slightly different type than expected, which may in return lead to a crashing Roc program, though the _$ run check <Roc program>_ (in Linux) before command went OK.

<br/>

#### #2 -- Records are good

Second, I noticed from the "Towers of Hanoi" example how much flexibility **records** in Roc provide:

```
  # user defined record for state of the number generation:
  State : {
    y : U32,        # prior number
    limit: U32,     # how many number still to generate
    x : List (U32)  # list of generated integer numbers
  }
```

Again, be precise with the (data) types.

<br/>

#### #3 -- Have exact argument names in function calls

This is the core of this little program:

```
  # user defined, pure function:
  int_generate : State -> List (U32)
  int_generate = |{y,limit,x}|  # |...| = function arguments
         if limit > 1 then
           list0 = List.append(x,y)
           z = y + 1            # calculate next number
           int_generate({y : z,limit : limit-1,x : list0})  # recursion
         else
           List.append(x,y)
```

A challenge for some time was this line:

```
           int_generate({y : z,limit : limit-1,x : list0})  # recursion
```

I learned that in this function call I had to name the arguments exactly like given in the definition:

```
  int_generate = |{y,limit,x}|  # |...| = function arguments
```

So, I could not have other names or names just introduced before, for example like this non-working example:

```
           int_generate({z,limit-1,list0})  # recursion
```

<br/>

#### #4 -- Beware of the last expression of a function

This line also took its time:

```
           list0 = List.append(x,y)
```

First, I did not assign the return of the _append_ method on List _x_ to any name:

```
           List.append(x,y)
```

This does not work (here). So, I provided (arbitrary) name _list0_ for the returned List of _List.append(x,y)_, which is then also the name of the List provided to the recursive function call.

However, you must not assign a name to the returned List, if an operation is the last expression of a function, like here:

```
         else
           List.append(x,y)
```

Otherwise the compiler would complain like this: "... Looks like the indentation ends prematurely here. Did you mean to have another expression after this line?"

<br/>

#### Program outcome

And this is the outcome of this program printed to the (Linux) console:

_... $ roc simple_counting_solution_#2.roc_

_0_

_1_

_2_

_3_

_4_

_5_

_6_

_7_

_8_

_9_

_Bye._

_... $_

<br/>

##_end
