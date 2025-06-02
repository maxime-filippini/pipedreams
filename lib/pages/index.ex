defmodule Pages.Index do
  use Phoenix.Component

  def index(assigns) do
    ~H"""
    <Layouts.Main.main>
      <div class="flex flex-col gap-4">
      <Components.AllTags.main tags={@tags}/>
      <div class="mt-4 mb-4 border-b border-violet-200"></div>
      <Components.AllPosts.main posts={@posts}/>
      </div>
    </Layouts.Main.main>
    """
  end
end
