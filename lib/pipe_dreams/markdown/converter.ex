defmodule PipeDreams.Markdown.Converter do
  def convert(filepath, body, _attrs, _opts) do
    IO.puts(filepath)

    if Path.extname(filepath) in [".md", ".markdown"] do
      MDEx.new()
      |> MDExMermaid.attach()
      |> MDEx.to_html!(document: body, extension: [math_dollars: true, math_code: true])
    end
  end
end
