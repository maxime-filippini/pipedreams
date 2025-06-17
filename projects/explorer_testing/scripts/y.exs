require Explorer.DataFrame, as: DF
require Explorer.Series, as: DS

defmodule TensorMath do
  import Nx.Defn

  defn subtract(a, b) do
    a - b
  end
end

# Define a new dataframe
DF.new(%{
  a: [1, 2, 3, 4, 5, 6],
  b: [3, 3, 4, 4, 5, 5]
})

# Add a computed column via a lazy computation
|> DF.mutate(c: a - b)

# Use conditionals to build new columns
|> DF.mutate(
  d:
    cond do
      c > 0 -> 1
      c < 0 -> -1
      true -> 0
    end
)

# Apply functions that operates on series directly
|> DF.mutate(ee: exp(d))

# Apply Elixir/Erlang functions on each element
|> Kernel.then(fn df ->
  df
  |> DF.put(
    :ff,
    DS.transform(df["ee"], fn x ->
      :math.sqrt(x)
    end)
  )
end)

# Apply a function that operates on tensors
|> Kernel.then(fn df ->
  df
  |> DF.put(
    :gg,
    TensorMath.subtract(df["a"], df["b"])
    |> DS.from_tensor()
  )
end)

# Filter based on column values
|> DF.filter(a < 4)

# Only keep some columns based on a function evaluation
|> DF.select(fn c -> String.length(c) == 2 end)

# Display the table
|> DF.print()
