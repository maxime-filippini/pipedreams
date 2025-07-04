FROM elixir:1.18.3-alpine AS build
WORKDIR /app

COPY mix.exs mix.lock ./
RUN mix local.hex --force \
 && mix local.rebar --force \
 && mix deps.get --only prod

COPY config ./config
COPY lib ./lib
COPY priv ./priv

COPY posts ./posts

RUN mix site.build

FROM pierrezemb/gostatic
COPY --from=build /app/output/ /srv/http/
