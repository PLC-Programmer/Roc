2025-04-17, work in progress

<br/>


# How to make a simple "for-loop" in Roc?

or maybe similarly in other (purely) functional programming languages.

Like this for example: https://github.com/PLC-Programmer/Roc/blob/main/simple_counting.roc

Effect in Ubuntu 24 LTS:

_$ roc simple_counting.roc_

_0,11,22,33,44,55,66,77,88,99,110,121,132,143,154_

_Bye._

_$_

I just added the factor 11 to index i to better see the effect. So, the default or neutral factor would be just 1 to loop from 0 to 14 inclusively.

<br/>

There are two "tricks" involved:

#### Trick #1: _List.range_

Since there's is no keyword "for" like in _imperative_ programming for example, something else must be used.

For example the _range_ method from an "Exposed Module" named _List_, which is a "builtin" in Roc:

```
...List.range({start: At 0, end: Before upper_limit})
```

See: https://www.roc-lang.org/builtins/List#range

_List.range()_ returns a list of all integer numbers from _start_ to _end_ (just ending before the _upper_limit_ to be a little bit "pythonic" here).

I picked this up from this example: https://www.roc-lang.org/examples/FizzBuzz/README.html

However, I could not use the next function in this **pipe**, indicated with symbol _|>_ :  _|> List.map(fizz_buzz)_

..since I do not want to convert all the integer numbers that _List.range()_ returned (with a function called _fizz_buzz_).

This was the hardest part for me to figure out: what to do exactly with the returned list of integer numbers, so that these numbers can be **later** used in the program?

<br/>

#### Trick #2: _List.walk_

Then I saw this example from the Documentation: [walk!](https://www.roc-lang.org/builtins/List#walk!)

```
now_multiples = List.walk!([1, 2, 3], [], \nums, i ->
     now = Utc.now!({}) |> Utc.to_millis_since_epoch
     List.append(nums, now * i)
)
```

It features a so called _**effectful function**_ _List.walk!()_, indicated with symbol _!_, which is featuring another effectful function _Utc.now!()_.

_List.walk!()_ starts with an empty List _[]_ and has function arguments _nums_ and _i_, indicated with the **lambda symbol** _\\_ (for λ) to indicate an "ad-hoc function".
".

These two arguments go into the following function, indicated with symbol _->_, which is called the **step function**.

So, a list of _Utc.now_ time elements in milliseconds is created, where each time element is just multiplied with the element from the input list _[1, 2, 3]_.

That was my solution, only simpler:

```
  s = List.range({start: At 0, end: Before upper_limit})
      |> List.walk([], \nums, i -> List.append(nums, i*11))
```

I even left the argument names as given in the official example.

With _s_ I have a list of integer numbers from _start_ to _end_ (exclusively) and multiplied with 11 for fun.

<br/>

#### Transforming one list into another, here for console output: _List.map_

In a next step, the program is converting these numbers of type I32 into strings, concatenates them and finally puts this common string to the console:

```
# only printing
  List.map(s, int_conv)
    |> Str.join_with(",")
    |> Stdout.line!()?  # "?"!
  # only for printing
  int_conv : I32 -> Str
  int_conv = |num|
             Num.to_str(num)
```

I took this part from official example [FizzBuzz](https://www.roc-lang.org/examples/FizzBuzz/README.html) 

Also note the last expression of the program:

```
  Stdout.line!("Bye.")
```

There, no **postfix operator** _?_ is used like in the "printing loop" with: _|> Stdout.line!()?_

See from the tutorial again: https://www.roc-lang.org/tutorial#the-question-postfix-operator

So, _?_, also called the "try operator", is "syntax sugar" for _Result.try_: https://www.roc-lang.org/examples/Results/README.html

(draft)
In the "printing loop", piping the common string to _Stdout_ can cause an error which should be taken care of, something we don't need at final expression _Stdout.line!("Bye.")_.

<br/>

About this "|...|" notation at **function definition** _int_conv = |num|_: see from the tutorial again: https://www.roc-lang.org/tutorial#defining-functions

My user defined function _int_conv_ takes _num_ as its argument and converts this number of type _Num_ (https://www.roc-lang.org/builtins/Num) into a string.

So, whenever _int_conv_ is called, a _Num.to_str(num)_ evaluation happens.

<br/>

##_end
