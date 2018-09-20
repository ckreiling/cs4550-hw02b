defmodule Practice.Calc do
  import Practice.Utils

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    expr
    |> String.split(~r/\s+/)
    |> Enum.map(fn x -> 
      cond do
        Enum.member?(["+", "-", "/", "*"], x) -> { :op, x }
        true -> { :num, parse_float(x) }  # Don't need to worry about error case
      end
    end)
    |> Enum.reduce([], fn x, acc -> 
      cond do
        elem(x, 0) == :num -> ""
      end
    end)
    |> Enum.reverse

    # Hint:
    # expr
    # |> split
    # |> tag_tokens  (e.g. [+, 1] => [{:op, "+"}, {:num, 1.0}]
    # |> convert to postfix
    # |> reverse to prefix
    # |> evaluate as a stack calculator using pattern matching
  end
  
  def factor(x) do
    find_factors(x)
    |> Enum.filter(fn i -> i != 1 end)
  end

  # Have to define this here so the the other find_factors isn't run first
  def find_factors(x, n \\ 2)
  def find_factors(x, 2) do
    cond do
      rem(x, 2) == 0 -> [2 | find_factors(div(x, 2))]
      4 > x -> [x]
      true -> find_factors(x, 3)
    end
  end

  def find_factors(x, n) do
    cond do
      rem(x, n) == 0 -> [n | find_factors(div(x, n))]
      x < n * 2 -> [x]
      true -> find_factors(x, n + 2)
    end
  end
end
