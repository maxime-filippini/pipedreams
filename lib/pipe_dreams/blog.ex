defmodule PipeDreams.Blog do
  alias PipeDreams.Post
  alias PipeDreams.Markdown

  use NimblePublisher,
    build: Post,
    from: "./posts/**/*.md",
    as: :posts,
    html_converter: Markdown.Converter

  @posts Enum.sort_by(@posts, & &1.date, {:desc, Date})

  def all_posts, do: @posts

  def all_tags() do
    @posts
    |> Enum.reduce(%{}, fn post, acc ->
      Enum.reduce(post.tags, acc, fn tag, acc2 ->
        Map.update(acc2, tag, 1, &(&1 + 1))
      end)
    end)
    |> Map.to_list()
    |> Enum.sort_by(fn {_tag, count} -> count end, :desc)
  end
end
