defmodule Components.AllTags do
  use Phoenix.Component

  def main(assigns) do
    ~H"""
    <div class="w-full flex flex-col gap-4">
    <h1 class="text-2xl font-semibold mb-4">All tags</h1>
    <ul class="flex gap-4 flex-wrap">
    <li :for={{tag, count} <- @tags} class="">
    <a class="px-4 py-2 bg-violet-100 rounded-lg hover:bg-violet-200 duration-200"
       href={"/tags/#{tag}.html"}>
    {tag}&nbsp;({count})
    </a>
    </li>
    </ul>
    </div>
    """
  end
end
