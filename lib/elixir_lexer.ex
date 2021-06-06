defmodule ResaltadorParalelo do
  def add_tags(list) do
    list |> Enum.map(fn {token, _, chars} ->
      case token do
        :integer ->
          "<a style='color:#2a6edb;'>#{chars}</a>"
        :float ->
          "<a style='color:#2a6edb'>#{chars}</a>"
        :hexadecimal ->
          "<a style='color:#2a6edb;'>#{chars}</a>"
        :octal ->
          "<a style='color:#2a6edb;'>#{chars}</a>"
        :binary ->
          "<a style='color:#2a6edb;'>#{chars}</a>"
        :unicode_point ->
          "<a style='color:#2a6edb;'>#{chars}</a>"
        :atom ->
          "<a style='color:aquamarine;'>#{chars}</a>"
        :single_quoted_atom ->
          "<a style='color:aquamarine;'>#{chars}</a>"
        :double_quoted_atom ->
          "<a style='color:aquamarine;'>#{chars}</a>"
        :keyword_atom ->
          "<a style='color:#2a6edb;'>#{chars}</a>"
        :string ->
          "<a style='color:greenyellow;'>#{chars}</a>"
        :multiline_string ->
          "<a style='color:greenyellow;'>#{chars}</a>"
        :charlist ->
          "<a style='color:greenyellow;'>#{chars}</a>"
        :multiline_charlist ->
          "<a style='color:greenyellow;'>#{chars}</a>"
        :delimiter ->
          "<a style='color:red;'>#{chars}</a>"
        :variable ->
          "<a style='color:sandybrown;'>#{chars}</a>"
        :hidden_variable ->
          "<a style='color:grey;'>#{chars}</a>"
        :alias ->
          "<a style='color:gold;'>#{chars}</a>"
        :comment ->
          "<a style='color:grey;'>#{chars}</a>"
        :newline ->
          "<div>\n</div>"
        :skip ->
          "<a>#{chars}</a>"
        :reserved_atom ->
          "<a style='color:#2a6edb;'>#{chars}</a>"
        :reserved_operator ->
          "<a style='color:violet;'>#{chars}</a>"
        :reserved_fn ->
          "<a style='color:violet;'>#{chars}</a>"
        :reserved_block ->
          "<a style='color:violet;'>#{chars}</a>"
        :reserved_general ->
          "<a style='color:violet;'>#{chars}</a>"
        :operator ->
        "<a style='color:red;'>#{chars}</a>"
      end
    end
    )
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
