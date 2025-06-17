defmodule NewsClient.LiteCnn do
  @root_url "https://lite.cnn.com"

  def get_headlines do
    page = Req.get!(@root_url)
    {:ok, document} = Floki.parse_document(page.body)

    document
    |> Floki.find("li.card--lite > a")
    |> Enum.map(fn a ->
      href =
        Floki.attribute(a, "href")
        |> List.first()

      text =
        a
        |> Floki.text()
        |> String.trim()

      {@root_url <> href, text}
    end)
  end

  def get_article(url) do
    page = Req.get!(url)
    {:ok, document} = Floki.parse_document(page.body)

    document
    |> Floki.find("article")
    |> Floki.text()
  end
end
