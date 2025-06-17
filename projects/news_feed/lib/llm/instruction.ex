defmodule Llm.Instruction do
  defstruct model: "gpt-4o-mini", messages: [], tools: []
end

defmodule Llm.InstructionBuilder do
  def set_model(%Llm.Instruction{} = inst, model) do
    %{inst | model: model}
  end

  def add_message(%Llm.Instruction{} = inst, role, msg) do
    %{inst | messages: inst.messages ++ [%{role: role, content: msg}]}
  end

  def add_tool(%Llm.Instruction{} = inst, tool) do
    %{inst | tools: [tool | inst.tools]}
  end
end
