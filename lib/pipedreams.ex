defmodule PipeDreams do
  use Phoenix.Component

  @output_dir "./output"

  File.mkdir_p!(@output_dir)

  def build() do
    posts = PipeDreams.Blog.all_posts()
    tags = PipeDreams.Blog.all_tags()

    render_file("index.html", Pages.Index.index(%{posts: posts, tags: tags}))

    for post <- posts do
      dir = Path.dirname(post.path)

      if dir != "." do
        File.mkdir_p!(Path.join([@output_dir, dir]))
      end

      render_file(post.path, Layouts.Post.post(%{post: post}))
    end

    tag_path = Path.join([@output_dir, "tags"])

    File.mkdir_p!(tag_path)

    for {tag, _count} <- tags do
      path = "tags/#{tag}.html"

      posts_in_tag =
        posts
        |> Enum.filter(fn post -> tag in post.tags end)

      render_file(path, Layouts.Tag.main(%{tag: tag, posts: posts_in_tag}))
    end

    :ok
  end

  def render_file(path, rendered) do
    safe = Phoenix.HTML.Safe.to_iodata(rendered)
    output = Path.join([@output_dir, path])
    File.write!(output, safe)
  end
end
