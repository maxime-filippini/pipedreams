defmodule Components.AllPosts do
  use Phoenix.Component

  def main(assigns) do
    ~H"""
      <div class="flex flex-col gap-4">
      <h2 class="text-2xl font-semibold">All posts</h2>
      <ul class="flex flex-col flex-1 gap-4">
        <li :for={post <- @posts}>
          <a href={post.path} class="flex gap-4 p-4 font-mono rounded-lg bg-violet-100">
            <p class="w-1/2 sm:w-1/4">[{post.date}]</p>
            <div class="flex flex-col w-1/2 gap-4 sm:w-3/4 class">
              <p>{post.title}</p>
              <p class="hidden text-sm italic sm:block">{post.description}</p>
              <div class="flex hidden gap-4 sm:block">
                <ul class="flex flex-wrap gap-2">
                  <li :for={tag <- post.tags} class="px-2 rounded-lg bg-violet-200">
                    {tag}
                  </li>
                </ul>
              </div>
            </div>
          </a>
        </li>
      </ul>
      </div>
    """
  end
end
