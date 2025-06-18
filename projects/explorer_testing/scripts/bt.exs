require Explorer.DataFrame, as: DF
require Explorer.Series, as: DS

n = 5000
var_cf = 0.99
th_os = 1 - var_cf
window = 250
test_cf = 0.05

{arr, _new_key} =
  Nx.Random.key(1)
  |> Nx.Random.uniform(shape: {n})

# Simulated dataset
df =
  DF.new(%{
    # An incrementing row index
    idx: Nx.iota({n}) |> DS.from_tensor(),
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

# Only retain important information
# |> DF.filter(p_value < ^test_cf)
# |> DF.select([:idx, :kupiec_lr, :p_value])
# |> DF.print()

alias VegaLite, as: Vl

# Create a new chart
Vl.new(
  width: 800,
  height: 400,
  title: "Kupiec POF p-values over time"
)
|> Vl.config(
  view: [fill: :white],
  padding: 20
)
# Bind data to the chart
|> Vl.data_from_values(
  idx: df["idx"] |> DS.to_list(),
  p_value: df["p_value"] |> DS.to_list()
)
|> Vl.layers([
  # Our first layer, the actual data
  Vl.new()
  |> Vl.mark(:line)
  |> Vl.encode_field(:x, "idx", type: :quantitative, axis: [title: "Time step"])
  |> Vl.encode_field(:y, "p_value", type: :quantitative, axis: [format: ".0%", title: "P-value"]),

  # A horizontal line that shows the p-value threshold
  Vl.new()
  |> Vl.mark(:rule, color: "red", stroke_dash: [4, 4])
  |> Vl.encode(:y, datum: 0.05, type: :quantitative)
])
# Conversion to an image file
|> VegaLite.Convert.save!("vegalite-chart.png", ppi: 300)
