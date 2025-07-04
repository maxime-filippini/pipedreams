defmodule Layouts.Post do
  use Phoenix.Component
  import Phoenix.HTML
  alias Layouts.Main

  def post(assigns) do
    ~H"""
    <Main.main>
      <div class="flex flex-col gap-4 pb-4 mb-4 border-b border-violet-200">
        <h1 class="pb-6 text-3xl font-semibold border-b border-violet-200">{@post.title}</h1>
        <p class="font-semibold">Tags</p>
        <ul class="flex flex-wrap gap-4 mb-4">
          <li :for={tag <- @post.tags}>
            <a class="px-4 py-2 duration-200 rounded-lg bg-violet-100 hover:violet-200" href={"/tags/#{tag}.html"}>{tag}</a>
          </li>
        </ul>
      </div>
      <article class="prose prose-violet sm:prose-lg">
        <%= raw @post.body %>
      </article>
    </Main.main>
    """
  end
end
