# Used by "mix format"
[
  inputs: ["mix.exs", "{config,lib,test}/**/*.{ex,exs}"],
  locals_without_parens: [
    # Routing
    plug: :*,
    pipe_through: :*,
    match: :*,
    get: :*,
    post: :*,
    put: :*,
    patch: :*,
    delete: :*,
    forward: :*,

    # Test
    on_exit: :*
  ]
]
