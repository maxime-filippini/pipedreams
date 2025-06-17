defmodule LlmAgent do
  defmacro __using__(opts) do
    quote do
      use GenServer

      @api_url "https://api.openai.com/v1/chat/completions"
      @headers [
        {"Content-Type", "application/json"},
        {"Authorization", "Bearer #{System.get_env("OPENAI_API_KEY")}"}
      ]

      def start_link(name) do
        GenServer.start_link(__MODULE__, %{}, name: name)
      end

      def continue_chat(state) do
        Task.Supervisor.async(TaskSup, fn ->
          body =
            %{
              model: state.model,
              messages: state.messages,
              tools: Enum.map(state.tools, fn mod -> mod.toolspec() end)
            }

          resp =
            @api_url
            |> Req.post(headers: @headers, json: body, receive_timeout: 100_000)

          dbg(resp)

          resp
        end)

        state
      end

      def prompt(agent, prompt) do
        GenServer.call(agent, {:prompt, prompt})
      end

      def messages(agent) do
        GenServer.call(agent, :messages)
      end

      # Callbacks
      @impl true
      def init(_opts) do
        me = __MODULE__

        state = %{
          state: :idle,
          model: unquote(opts)[:model],
          tools: unquote(opts)[:tools],
          messages: [%{role: "system", content: unquote(opts)[:system]}]
        }

        {:ok, state}
      end

      @impl true
      def handle_call({:prompt, prompt}, _from, state) do
        new_state = %{
          state
          | state: :active,
            messages: state.messages ++ [%{role: "user", content: prompt}]
        }

        {:reply, :ok, continue_chat(new_state)}
      end

      @impl true
      def handle_call(:messages, _from, state) do
        {:reply, state.messages, state}
      end

      @impl true
      def handle_call({:transfer, pid}, _from, state) do
        GenServer.cast(pid, {:set_state, state})
        GenServer.call(pid, {:prompt, "Carry on with your duties."})
      end

      @impl true
      def handle_cast({:set_state, s}, state) do
        s
      end

      @impl true
      def handle_info({_ref, {:ok, api_response}}, state) do
        message =
          api_response.body["choices"]
          |> Enum.at(0)
          |> Kernel.then(& &1["message"])

        {new_messages, should_stop} =
          case message do
            %{"tool_calls" => tools = [_ | _]} ->
              dbg(tools)

              tool_outputs =
                tools
                |> Enum.map(fn %{"id" => id, "function" => %{"arguments" => args, "name" => name}} ->
                  Task.Supervisor.async_nolink(TaskSup, fn ->
                    {tool_result, should_stop} = invoke_tool(name, args)

                    %{
                      role: "tool",
                      tool_call_id: id,
                      content: tool_result |> JSON.encode!(),
                      should_stop: should_stop
                    }
                  end)
                end)
                |> Enum.map(&Task.await(&1, 5_000))

              should_stop =
                tool_outputs
                |> Enum.filter(fn item -> item.should_stop end)
                |> Kernel.then(&(length(&1) > 0))

              tool_outputs =
                tool_outputs
                |> Enum.map(fn item ->
                  Map.pop(item, :should_stop)
                  |> Kernel.then(&elem(&1, 1))
                end)

              {[message | tool_outputs], should_stop}

            _ ->
              {[message | [%{role: "assistant", content: message["content"]}]], false}
          end

        new_state = %{state | messages: state.messages ++ new_messages}

        case should_stop do
          true ->
            {:noreply, new_state}

          _ ->
            {:noreply, continue_chat(new_state)}
        end
      end

      @impl true
      def handle_info({:DOWN, _ref, :process, _pid, _reason}, state) do
        {:noreply, state}
      end

      def invoke_tool(tool, params) do
        decoded = JSON.decode!(params)

        {output, should_stop?} =
          case tool do
            "greet_by_name" ->
              %{"name" => name} = decoded
              {Tools.Greeter.func(name), false}

            "stop" ->
              {Tools.Stopper.func(), true}

            _ ->
              {%{"message" => "Unknown tool!"}, true}
          end
      end

      @doc "Function called when the agent is called as a tool"
      def func() do
      end

      def toolspec do
        %{
          type: "function",
          function: %{
            name: "transfer_to_" <> unquote(opts)[:agent_name],
            strict: true,
            description: unquote(opts)[:tool_description],
            parameters: %{
              type: "object",
              properties: %{},
              required: [],
              additionalProperties: false
            }
          }
        }
      end
    end
  end
end

defmodule GreetingLlmAgent do
  use LlmAgent,
    system: """
      You are a greeter. If the user gives you a name, greet them based on that name.

      Otherwise, offer a standard greeting.
    """,
    tools: [Tools.Greeter, Tools.Stopper],
    model: "gpt-4o-mini",
    agent_name: "greeting_agent",
    tool_description: "Transfer the conversation to the greeting agent."
end
