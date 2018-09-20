defmodule Practice.Utils do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end
end