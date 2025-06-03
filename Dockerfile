FROM elixir:1.18.4-alpine AS build
WORKDIR /app
COPY mix.exs mix.lock ./

RUN mix local.hex --force \
 && mix local.rebar --force \
 && mix deps.get --only prod

COPY . .

RUN mix site.build

FROM pierrezemb/gostatic
COPY --from=build /app/output/ /srv/http/
