
Benchee.run(
  %{
    "sequential" => fn input -> ResaltadorParalelo.sequential_workflow(input) end,
    "parallel" => fn input -> ResaltadorParalelo.parallel_workflow(input) end
  },
  inputs: %{
    "5" => "./codes/5files",
    "10" => "./codes/10files",
  }
)
