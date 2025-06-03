defmodule Layouts.Main do
  use Phoenix.Component
  alias Components.Logo

  @current_year Date.utc_today().year

  def main(assigns) do
    assigns = assign_new(assigns, :current_year, fn -> @current_year end)

    ~H"""
    <!DOCTYPE html>
    <html lang="en">
      <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="/assets/app.css" />
        <script type="text/javascript" src="/assets/app.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.16.22/dist/katex.min.css" integrity="sha384-5TcZemv2l/9On385z///+d7MSYlvIEw9FuZTIdZ14vJLqWphw7e7ZPuOiCHJcFCP" crossorigin="anonymous">
        <link rel="icon" type="image/svg+xml" href="/assets/favicon.svg" />
        <script defer src="https://cdn.jsdelivr.net/npm/katex@0.16.22/dist/katex.min.js" integrity="sha384-cMkvdD8LoxVzGF/RPUKAcvmm49FQ0oxwDF3BGKtDXcEc+T1b2N+teh/OJfpU0jr6" crossorigin="anonymous"></script>
      </head>
      <body class="flex flex-col h-screen">
        <div class="flex-1 flex flex-col p-4">
        <div class="w-full flex flex border-b-2 mb-8 border-violet-200">
          <Logo.main/>
          <div class="ml-auto"></div>
        </div>
          <main class="flex-1 container mx-auto max-w-3xl">
            <%= render_slot(@inner_block) %>
          </main>
          <div class="flex gap-8">
            <p class="mr-auto"></p>
            <p>Maxime Filippini, {@current_year}</p>
          </div>
        </div>
      </body>
    </html>
    """
  end
end
