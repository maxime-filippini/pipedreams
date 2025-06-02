defmodule Layouts.Tag do
  use Phoenix.Component

  def main(assigns) do
    ~H"""
    <Layouts.Main.main>
    <div class="flex gap-8 text-2xl mb-4 items-center">
    <p class="text-middle">Posts tagged with</p>
    <p class="font-semibold italic px-4 py-2 bg-violet-100 rounded-lg">{@tag}</p>
    </div>

      <ul class="flex-1 flex flex-col gap-4">
        <li :for={post <- @posts}>
          <a href={"/#{post.path}"} class="font-mono flex gap-4 bg-violet-100 rounded-lg p-4">
            <p class="w-1/2 sm:w-1/4">[{post.date}]</p>
            <div class="w-1/2 sm:w-3/4 class flex flex-col gap-2">
              <p>{post.title}</p>
              <p class="italic text-sm hidden sm:block">{post.description}</p>
            </div>
          </a>
        </li>
      </ul>

    </Layouts.Main.main>
    """
  end
end
