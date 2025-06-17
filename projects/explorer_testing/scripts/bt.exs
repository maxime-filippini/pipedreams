require Explorer.DataFrame, as: DF
require Explorer.Series, as: DS

{arr, _new_key} =
  Nx.Random.key(1)
  |> Nx.Random.uniform(shape: {5000})

var_cf = 0.99
th_os = 1 - var_cf
window = 250
test_cf = 0.05

DF.new(%{
  rand: DS.from_tensor(arr)
})
# Define overshootings based on the outcome of random uniform sampling
|> DF.mutate(
  os:
    cond do
      rand < ^th_os -> 1
      true -> 0
    end
)
# Aggregate over 250-day windows
|> DF.mutate(n_os: window_sum(os, ^window))
# Remove while the first window is being built
|> DF.slice((window - 1)..-1//1)
|> DF.mutate(
  th_os: ^th_os,
  n_obs: ^window,
  f_os: n_os / ^window
)
# Compute the Kupiec likelihood ratio
|> DF.mutate(
  num: th_os ** n_os * (1 - th_os) ** (n_obs - n_os),
  denom: f_os ** n_os * (1 - f_os) ** (n_obs - n_os)
)
|> DF.mutate(kupiec_lr: -2 * log(num / denom))

# Compute the p-value for each value of the likelihood ratio
|> Kernel.then(fn df ->
  DF.put(
    df,
    :p_value,
    DS.transform(
      df["kupiec_lr"],
      fn x -> 1 - Statistics.Distributions.Chisq.cdf(1).(x) end
    )
  )
end)
|> DF.filter(p_value < ^test_cf)
|> DF.print()
