defmodule PipeDreams.MixProject do
  use Mix.Project

  def project do
    [
      app: :pipedreams,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  def aliases do
    [
      "site.build": [
        "build",
        fn _ -> Mix.shell().cmd("mix tailwind default", quiet: false) end,
        fn _ -> Mix.shell().cmd("mix esbuild default", quiet: false) end,
        fn _ -> Mix.shell().cmd("cp assets/favicon.svg output/assets") end,
        fn _ -> Mix.shell().cmd("cp -r assets/images output/assets") end
      ]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:nimble_publisher, "~> 1.0"},
      {:mdex, "~> 0.7"},
      {:mdex_mermaid, "~> 0.1"},
      {:phoenix_live_view, "~> 1.0"},
      {:esbuild, "~> 0.10.0"},
      {:tailwind, "~> 0.3.1"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
