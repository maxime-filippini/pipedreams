defmodule Components.Convo do
  use Phoenix.Component

  def main(messages: messages) when is_list(messages) do
    main(%{messages: messages})
  end

  def main(assigns = %{messages: messages}) do
    assigns = assign(assigns, :indexed_messages, Enum.with_index(messages))

    ~H"""
    <div class="flex flex-col w-full gap-4 p-8 bg-white border rounded-lg border-violet-300">
      <%= for {message, idx} <- @messages do %>
        <div
          class={
            if Integer.mod(idx, 2) == 0 do
              "px-4 py-2 text-left text-black border rounded-full bg-slate-300 border-slate-400"
            else
              "px-4 py-2 text-right text-white border rounded-full bg-violet-400 border-violet-600"
            end
          }
        >
          <%= message %>
        </div>
      <% end %>
    </div>
    """
  end
end
