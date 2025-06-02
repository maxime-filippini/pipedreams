defmodule Layouts.Post do
  use Phoenix.Component
  import Phoenix.HTML
  alias Layouts.Main

  def post(assigns) do
    ~H"""
    <Main.main>
      <div class="flex flex-col gap-4 mb-8">
      <h1 class="text-3xl font-semibold mb-6">{@post.title}</h1>

        <p class="font-semibold">Tags</p>
    <ul class="flex gap-4 flex-wrap">
          <li :for={tag <- @post.tags}>
            <a class="px-4 py-2 bg-violet-100 rounded-lg hover:violet-200 duration-200" href={"/tags/#{tag}.html"}>{tag}</a>
          </li>
        </ul>
      </div>
      <article class="prose">
        <%= raw @post.body %>
      </article>
    </Main.main>
    """
  end
end
