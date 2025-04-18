2025-04-18, work in progress

See [solution #1](https://github.com/PLC-Programmer/Roc/blob/main/README.md)

<br/>

# How to make a simple "for-loop" in Roc? -- solution #2

Roc source code: https://github.com/PLC-Programmer/Roc/blob/main/simple_counting_solution_%232.roc

This example heavily leans into this official example: https://www.roc-lang.org/examples/TowersOfHanoi/README.html

..and thus is based on **recursion**, here with a user defined, "pure" function named _int_generate_.

However, to convert the "Towers of Hanoi" example into a simple, recursive function to just count from 0 to 9 (inclusively) had its challenges too.

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





















(TBD)

<br/>

##_end
