defmodule Components.Logo do
  use Phoenix.Component

  def main(assigns) do
    ~H"""
      <a class="text-3xl font-semibold pb-8" href="/">
      <p class="p-4 bg-white border rounded-lg hover:bg-slate-50 duration-200">
      <span class="font-mono">pipe</span> <span class="mx-2 text-violet-300">|&gt;</span>
      <span class="font-mono">dreams()</span>
      </p>
      </a>
    """
  end
end
