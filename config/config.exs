import Config

config :esbuild,
  version: "0.25.0",
  default: [
    args:
      ~w(app.js --bundle --target=es2017 --outdir=../output/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

config :tailwind,
  version: "4.0.9",
  default: [
    args: ~w(
      -i ./css/app.css
      -o ../output/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]
