
Benchee.run(
  %{
    "sequential_20" => fn -> ResaltadorParalelo.sequential_workflow("./codes") end,
    "parallel_20" => fn -> ResaltadorParalelo.parallel_workflow("./codes") end
  }
)
