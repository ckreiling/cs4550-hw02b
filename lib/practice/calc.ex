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
        elem(x, 0) == :num
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
end
