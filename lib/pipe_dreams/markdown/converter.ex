defmodule PipeDreams.Markdown.Converter do
  require EEx

  def convert(filepath, body, attrs, _opts) do
    if Path.extname(filepath) in [".md", ".markdown"] do
      body_eex = body |> EEx.eval_string(assigns: attrs)

      MDEx.new()
      |> MDExMermaid.attach()
      |> MDEx.to_html!(
        document: body_eex,
        render: [unsafe_: true],
        extension: [math_dollars: true, math_code: true, table: true]
      )
    end
  end
end
