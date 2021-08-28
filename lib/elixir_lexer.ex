defmodule ResaltadorParalelo do

  def add_tags(list) do
    list |> Enum.map(fn {token, _, chars} -> Style.edit(token, chars)
    end)
end

  def create_file(input_file, output_file) do
    output_text = File.read!(input_file)
    |> to_charlist
    |> :lexer.string
    |> elem(1)
    |> add_tags
    output_text = "<html><head><link rel='stylesheet' href='styles.css'></head><code>#{output_text}</code></html>"
    # IO.inspect(output_text)
    File.write!(output_file, output_text)
  end

  def sequential_workflow(path) do
     for file <- File.ls!(path) do
      file
     end
     |> Enum.map(fn input_file -> create_file("#{path}/#{input_file}", "./outputFiles/#{input_file}.html") end )
  end

  def parallel_workflow(path) do
    for file <- File.ls!(path) do
      file
    end
    |> Enum.map(fn input_file -> Task.async(fn -> create_file("#{path}/#{input_file}", "./outputFiles/#{input_file}.html") end ) end)
    |> Enum.map(fn task -> Task.await(task) end)
  end

end
