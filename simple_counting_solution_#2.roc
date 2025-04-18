app [main!] {
              cli: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
            }

import cli.Stdout

main! = |_args|
  upper_limit = 10u32

  counter_start = 0u32

  # user defined record for state of the number generation:
  State : {
    y : U32,        # prior number
    limit: U32,     # how many number still to generate
    x : List (U32)  # list of generated integer numbers
  }

  # user defined, pure function:
  int_generate : State -> List (U32)
  int_generate = |{y,limit,x}|  # |...| = function arguments
         if limit > 1 then
           list0 = List.append(x,y)
           z = y + 1            # calculate next number
           int_generate({y : z,limit : limit-1,x : list0})  # recursion
         else
           List.append(x,y)

  # make a list of integer numbers:
  s = int_generate({y : counter_start, limit : upper_limit, x : []})
  
  # only printing:
  List.map(s, int_conv)
    |> Str.join_with("\n")
    |> Stdout.line!()?
  int_conv : U32 -> Str
  int_conv = |num|
             Num.to_str(num)

  Stdout.line!("Bye.")
