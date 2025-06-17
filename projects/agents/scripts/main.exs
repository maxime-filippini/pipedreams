{:ok, pid} = GreetingLlmAgent.start_link(:greeter)

GreetingLlmAgent.prompt(pid, "Hello, my name is Maxime")

:timer.sleep(4000)

IO.inspect(GreetingLlmAgent.messages(pid))
