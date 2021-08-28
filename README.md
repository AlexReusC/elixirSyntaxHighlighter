# Resaltador_paralelo

**Lexer para elixir (sync y async)**

## Uso con resaltador secuencial

En iex -S mix usa ResaltadorParalelo.sequential_workflow(<dirección de los archivos>)
Eg.

```elixir
ResaltadorParalelo.sequential_workflow("./codes/5files")
```

## Uso con resaltador paralelo

En iex -S mix usa ResaltadorParalelo.parallel_workflow(<dirección de los archivos>)
Eg.

```elixir
ResaltadorParalelo.parallel_workflow("./codes/5files")
```

## Comparar performance

Usar en terminal el comando mix run run_defaults.exs

