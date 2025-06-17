alias VegaLite, as: Vl

n = 500

{arr, _new_key} =
  Nx.Random.key(420)
  |> Nx.Random.normal(0, 1, shape: {n})

s = Explorer.Series.from_tensor(arr)

idx = Explorer.Series.row_index(s)
df = Explorer.DataFrame.new(%{index: idx, value: s})

vl =
  Vl.new(width: 600, height: 300)
  |> Vl.data_from_values(df)
  |> Vl.mark(:line)
  |> Vl.encode_field(:x, "index", type: :quantitative)
  |> Vl.encode_field(:y, "value", type: :quantitative)

vl
|> VegaLite.Convert.save!("chart.svg", format: :svg)
