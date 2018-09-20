defmodule PracticeWeb.PageController do
  use PracticeWeb, :controller
  import Practice.Utils

  def index(conn, _params) do
    render conn, "index.html"
  end

  def double(conn, %{"x" => x}) do
    {x, _} = Integer.parse(x)
    y = Practice.double(x)
    render conn, "double.html", x: x, y: y
  end

  def calc(conn, %{"expr" => expr}) do
    y = Practice.calc(expr)
    render conn, "calc.html", expr: expr, y: y
  end

  def factor(conn, %{"x" => x}) do
    if String.length(x) > 25 do
      render conn, "factor_error.html"
    else
      {arg, _} = Integer.parse(x)
      y = Practice.factor(arg)
      render conn, "factor.html", x: x, y: Enum.join(y, ", ")
    end
  end

  def palindrome(conn, %{"x" => x}) do
    y = Practice.palindrome?(x)
    render conn, "palindrome.html", x: x, y: y
  end
end
