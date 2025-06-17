defmodule Quadratic do
  import Nx.Defn

  defn f(x, a, b, c) do
    a * x ** 2 + b * x + c
  end

  defn gradient(x, a, b, c) do
    grad(fn x -> f(x, a, b, c) end).(x)
  end
end

{a, b, c} = {1, 2, 3}
x = 0

Quadratic.gradient(x, a, b, c) |> Nx.to_number() |> IO.inspect()
IO.inspect(2 * a * x + b)
