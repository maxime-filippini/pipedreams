# 3. Custom stats

defmodule Stats do
  import Nx.Defn

  defn quantile(t, q) do
    sorted = Nx.sort(t)
    {n} = Nx.shape(sorted)

    # The exact fractional index for our quantile
    idx = Nx.multiply(Nx.as_type(n - 1, :f32), q)

    # Linear interpolation
    lower = Nx.floor(idx) |> Nx.as_type({:s, 64})
    upper = Nx.ceil(idx) |> Nx.as_type({:s, 64})

    v0 = Nx.take(sorted, lower)
    v1 = Nx.take(sorted, upper)

    w = idx - Nx.floor(idx)
    v0 * (1 - w) + v1 * w
  end

  defn ecdf(t) do
    sorted = Nx.sort(t)
    {n} = Nx.shape(sorted)
    nf = Nx.as_type(n, :f32)

    ones = Nx.broadcast(1.0, {n})
    cumcounts = Nx.cumulative_sum(ones)

    ps = cumcounts / nf

    # We re-obtain the indexes of the original tensor
    sorted_indices = Nx.argsort(t)
    inv_indices = Nx.argsort(sorted_indices)

    # We re-index the probabilities to get those in the original order
    Nx.take(ps, inv_indices)
  end
end

require Explorer.Series, as: DS

require Explorer.DataFrame, as: DF

{arr, _new_key} =
  Nx.Random.key(1)
  |> Nx.Random.normal(0, 1, shape: {500})

defmodule Stats do
  import Nx.Defn

  defn quantile(t, q) do
    sorted = Nx.sort(t)
    {n} = Nx.shape(sorted)

    # The exact fractional index for our quantile
    idx = Nx.multiply(Nx.as_type(n - 1, :f32), q)

    # Linear interpolation
    lower = Nx.floor(idx) |> Nx.as_type({:s, 64})
    upper = Nx.ceil(idx) |> Nx.as_type({:s, 64})

    v0 = Nx.take(sorted, lower)
    v1 = Nx.take(sorted, upper)

    w = idx - Nx.floor(idx)
    v0 * (1 - w) + v1 * w
  end

  defn ecdf(t) do
    sorted = Nx.sort(t)
    {n} = Nx.shape(sorted)
    nf = Nx.as_type(n, :f32)

    ones = Nx.broadcast(1.0, {n})
    cumcounts = Nx.cumulative_sum(ones)

    ps = cumcounts / nf

    # We re-obtain the indexes of the original tensor
    sorted_indices = Nx.argsort(t)
    inv_indices = Nx.argsort(sorted_indices)

    # We re-index the probabilities to get those in the original order
    Nx.take(ps, inv_indices)
  end
end

Stats.quantile(arr, 0.99)
|> IO.inspect()

require Explorer.DataFrame, as: DF
require Explorer.Series, as: DS

ds = DS.from_tensor(arr)

df =
  DF.new(%{
    idx: DS.row_index(ds),
    sims: ds,
    ecdf: ds |> Stats.ecdf() |> DS.from_tensor()
  })

df
|> DF.mutate(
  tail:
    cond do
      ecdf < 0.05 -> true
      true -> false
    end
)
|> DF.print()

df
|> DF.filter(tail == true)
|> DF.print()
