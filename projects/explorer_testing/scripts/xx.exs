require Explorer.DataFrame, as: DF
require Explorer.Series, as: DS

defmodule TensorMath do
  import Nx.Defn

  defn subtract(a, b) do
    a - b
  end
end

{arr, _new_key} =
  Nx.Random.key(1)
  |> Nx.Random.normal(0, 1, shape: {500})

defmodule ExplorerUtils do
  def add_columns_from_tensor(df, exprs \\ []) do
    new_cols =
      exprs
      |> Enum.map(fn {k, vv} ->
        {k, vv.(df) |> DS.from_tensor()}
      end)

    df |> DF.mutate_with(new_cols)
  end
end

df = DF.new(%{data: arr, v: Nx.tensor(1)})

df |> DF.print()

# df =
#   DF.new(%{
#     a1: Nx.slice_along_axis(arr, 0, 1, axis: 1) |> Nx.squeeze() |> DS.from_tensor(),
#     a2: Nx.slice_along_axis(arr, 1, 1, axis: 1) |> Nx.squeeze() |> DS.from_tensor()
#   })
#   |> Kernel.then(
#     &DF.put(
#       &1,
#       :sub,
#       TensorMath.subtract(&1["a1"], &1["a2"])
#     )
#   )
