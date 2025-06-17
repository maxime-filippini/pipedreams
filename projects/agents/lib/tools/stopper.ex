defmodule Tools.Stopper do
  def toolspec do
    %{
      type: "function",
      function: %{
        name: "stop",
        strict: true,
        description: "Stop execution",
        parameters: %{
          type: "object",
          properties: %{},
          required: [],
          additionalProperties: false
        }
      }
    }
  end

  def func() do
    :ok
  end
end
