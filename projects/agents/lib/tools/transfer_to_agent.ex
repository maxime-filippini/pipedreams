defmodule Tools.TransferTo do
  def toolspec do
    %{
      type: "function",
      function: %{
        name: "transfer_to_agent",
        strict: true,
        description: "Transfer the conversation to another agent.",
        parameters: %{
          type: "object",
          properties: %{
            agent: %{
              type: "string",
              description: "The name of the agent"
            }
          },
          required: ["name"],
          additionalProperties: false
        }
      }
    }
  end

  def func(name) do
    :ok
  end
end
