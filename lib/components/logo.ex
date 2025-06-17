defmodule Components.Logo do
  use Phoenix.Component

  def main(assigns) do
    ~H"""
      <a class="mb-4 text-3xl font-semibold" href="/">
      <p class="p-2 duration-200 bg-white border rounded-lg hover:bg-slate-50">
      <span class="font-mono">pipe</span> <span class="mx-2 text-violet-300">|&gt;</span>
      <span class="font-mono">dreams()</span>
      </p>
      </a>
    """
  end
end
