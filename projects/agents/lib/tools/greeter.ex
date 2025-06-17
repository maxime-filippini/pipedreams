defmodule Tools.Greeter do
  def toolspec do
    %{
      type: "function",
      function: %{
        name: "greet_by_name",
        strict: true,
        description: "Greet a user by name",
        parameters: %{
          type: "object",
          properties: %{
            name: %{
              type: "string",
              description: "The name of the user"
            }
          },
          required: ["name"],
          additionalProperties: false
        }
      }
    }
  end

  def func(name) do
    greet =
      case name do
        "Maxime" -> "Hello there, Maxime!"
        x -> "Hi #{x}"
      end

    %{greet: greet, other: 1}
  end
end
