defmodule Llm.OpenAiClient do
  @api_url "https://api.openai.com/v1/chat/completions"
  @headers [
    {"Content-Type", "application/json"},
    {"Authorization", "Bearer #{System.get_env("OPENAI_API_KEY")}"}
  ]

  # def chat(%Instruction{} = instruction, _functions \\ []) do
  #   body =
  #     %{
  #       model: instruction.model,
  #       messages: instruction.messages
  #     }

  #   @api_url
  #   |> Req.post(headers: @headers, json: body)
  #   |> handle_response()
  # end

  # defp handle_response({:ok, %Req.Response{status: 200, body: body}}) do
  #   {:ok, body}
  # end

  # defp handle_response({:ok, resp}), do: {:error, resp}
  # defp handle_response({:error, reason}), do: {:error, reason}
end
