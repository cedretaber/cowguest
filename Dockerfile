FROM elixir:alpine

RUN apk update
RUN apk add build-base

COPY . /app/

RUN cd /app && \
    mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get

CMD cd /app && mix run --no-halt