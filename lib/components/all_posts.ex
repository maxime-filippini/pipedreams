defmodule Components.AllPosts do
  use Phoenix.Component

  def main(assigns) do
    ~H"""
      <div class="flex flex-col gap-4">
      <h2 class="text-2xl font-semibold">All posts</h2>
      <ul class="flex-1 flex flex-col gap-4">
        <li :for={post <- @posts}>
          <a href={post.path} class="font-mono flex gap-4 bg-violet-100 rounded-lg p-4">
            <p class="w-1/2 sm:w-1/4">[{post.date}]</p>
            <div class="w-1/2 sm:w-3/4 class flex flex-col gap-2">
              <p>{post.title}</p>
              <p class="italic text-sm hidden sm:block">{post.description}</p>
            </div>
          </a>
        </li>
      </ul>
      </div>
    """
  end
end
