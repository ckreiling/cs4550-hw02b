defmodule Practice.Utils do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  def parse_int(text) do
    {num, _} = Integer.parse(text)
    num
  end

  def empty_stack(%{stack: stack, acc: acc}) do
    if List.first(stack) do
      [head | tail] = stack
      empty_stack(%{ stack: tail, acc: acc ++ [head]})
    else
      acc
    end
  end
end