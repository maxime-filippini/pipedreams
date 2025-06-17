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
