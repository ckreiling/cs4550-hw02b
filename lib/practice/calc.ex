defmodule Practice.Calc do
  import Practice.Utils

  def precedence(str) do
    case str do
      "+" -> 1
      "-" -> 1
      "*" -> 2
      "/" -> 2
      _ -> -1 # should be a number
    end
  end

  def evaluate(operand, n1, n2) do
    case operand do
      "+" -> n1 + n2
      "-" -> n1 - n2
      "/" -> div(n1, n2)
      "*" -> n1 * n2
    end
  end

  def stack_calculator(postfix) do
    stack_calculator(postfix, [])
  end

  def stack_calculator([], stack) do 
    [head | tail] = stack
    head
  end

  def stack_calculator(postfix, stack) do
    if precedence(List.first(postfix)) != -1 do
      [first, second | rest] = stack
      [operator | tail] = postfix
      stack_calculator(tail, [evaluate(operator, second, first) | rest])
    else
      [head | rest] = postfix
      stack_calculator(rest, [head | stack])
    end
  end

  def operator_encountered({:op, x}, acc) do
    if List.first(acc[:stack]) && precedence(x) <= precedence(List.first(acc[:stack])) do
      [head | tail] = acc[:stack]
      operator_encountered({:op, x}, %{stack: tail, acc: acc[:acc] ++ [head]})
    else 
      %{stack: [x | acc[:stack]], acc: acc[:acc]}
    end
  end

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    expr
    |> String.split(~r/\s+/)
    |> Enum.map(fn x ->
      cond do
        precedence(x) != -1 -> { :op, x }
        true -> { :num, parse_int(x) }  # Don't need to worry about error case
      end
    end)
    |> Enum.reduce(%{stack: [], acc: []}, fn x, acc -> 
      cond do
        elem(x, 0) == :num -> %{ stack: acc[:stack], acc: acc[:acc] ++ [elem(x, 1)]}
        elem(x, 0) == :op -> operator_encountered(x, acc)
      end
    end)
    |> empty_stack() # need to empty the stack after the reduce call above
    |> stack_calculator()

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
