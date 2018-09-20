defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

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
    factor(x, div(x, 2))
    |> Enum.flat_map(fn i -> 
      if is_prime?(i) do
        [i]
      else
        factor(i)
      end
    end)
  end

  def factor(x, i) when x == 1 or i == 1 do [] end

  def factor(x, i) do
    if rem(x, i) == 0 do
      [i | factor(x, i - 1)]
    else
      factor(x, i - 1)
    end
  end

  def is_prime?(x) do
    factor(x) == []
  end
end
