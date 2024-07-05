# Used by "mix format"
[
  # inputs: ["{mix,.formatter}.exs", "{config,lib,test}/**/*.{ex,exs}"]
  inputs:
    Enum.flat_map(
      ["{mix,.formatter}.exs", "{config,lib,test}/**/*.{ex,exs}"],
      &Path.wildcard(&1, match_dot: true)
    ) -- ["test/table_formatter_test.exs"]
]
|> IO.inspect()
