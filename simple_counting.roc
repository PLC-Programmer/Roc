app [main!] {
              cli: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
            }

import cli.Stdout


main! = |_args|

  upper_limit = 15

  s = List.range({start: At 0, end: Before upper_limit})
      |> List.walk([], \nums, i -> List.append(nums, i*11))

  # only printing
  List.map(s, int_conv)
    |> Str.join_with(",")
    |> Stdout.line!()?  # "?"!
  # only for printing
  int_conv : I32 -> Str
  int_conv = |num|
             Num.to_str(num)

  Stdout.line!("Bye.")
