defmodule Garch do
  import Nx.Defn

  defn compute_vols(arr, vols, alpha, beta) do
    # total number of points
    n = Nx.axis_size(arr, 0)

    {filled, _} =
      while {filledidx}, Nx.less(idx, n) do
        prev_vol = Nx.slice(filled, [idx - 1], [1])

        {}
      end

    # # while {vols_tensor, idx}, idx < n, fill vols_tensor[idx]
    # {filled, _} =
    #   Nx.while(
    #     {vols_init, Nx.tensor(1, type: {:s, 64})},
    #     fn {_vols, idx} -> Nx.less(idx, n) end,
    #     fn {vols_acc, idx} ->
    #       # get previous vol and previous shock
    #       prev_vol = Nx.slice(vols_acc, [idx - 1], [1])
    #       prev_shock = Nx.slice(arr, [idx - 1], [1])

    #       # σ_next = sqrt(beta * σ_prev^2 + alpha * ε_prev^2)
    #       σ_next =
    #         prev_vol
    #         |> Nx.pow(2)
    #         |> Nx.multiply(beta)
    #         |> Nx.add(Nx.multiply(alpha, Nx.pow(prev_shock, 2)))
    #         |> Nx.sqrt()

    #       # write it back into the tensor at position idx
    #       {Nx.put_slice(vols_acc, [idx], σ_next), Nx.add(idx, 1)}
    #     end
    #   )

    filled
  end
end

# Outside your defn:
starting_vol = 0.005
alpha = 0.15
beta = 0.9

# 1) make your arr
{arr, _} = Nx.Random.key(1) |> Nx.Random.normal(0, 1, shape: {500})

# 2) build initial vols_init: first element = starting_vol, rest = 0
vols_init =
  Nx.tensor([starting_vol] ++ List.duplicate(0.0, 499), type: {:f, 32})

# 3) call the JIT-compiled function
vols = Garch.compute_vols(arr, vols_init, alpha, beta)
