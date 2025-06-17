defmodule Llm.Chat do
  defstruct messages: [], model: "gpt-4o-mini"

  def new do
    %Llm.Chat{}
  end

  def set_model(chat, model) do
    %Llm.Chat{chat | model: model}
  end

  def add_message(chat, role, msg) do
    %Llm.Chat{chat | messages: chat.messages ++ [%{role: role, content: msg}]}
  end
end
