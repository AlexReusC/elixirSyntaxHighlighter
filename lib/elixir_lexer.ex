defmodule ElixirLexer do
  def addTags(list) do
    list |> Enum.map(fn {token, _, chars} ->
        case token do
            :integer ->
             "<a style='color:red;'>#{chars}</a>"
            :float ->
              "<a style='color:coral;'>#{chars}</a>"
            :atom ->
              "<a style='color:aquamarine;'>#{chars}</a>"
            :singleQuotedAtom ->
              "<a style='color:aqua;'>#{chars}</a>"
            :dobleQuotedAtom ->
              "<a style='color:aqua;'>#{chars}</a>"
            :string ->
              "<a style='color:orange;'>#{chars}</a>"
            :multilineString ->
              "<a style='color:orangered;'>#{chars}</a>"
            :newline ->
              "<div>\n</div>"
            :skip ->
              "<a>#{chars}</a>"
            :reservedAtom ->
              "<a style='color:green;'>#{chars}</a>"
            :reservedOperator ->
              "<a style='color:green;'>#{chars}</a>"
            :+ ->
            "<a style='color:blue;'>#{chars}</a>"    
        end
    end
    )
end

def createFile(inputFile, outputFile) do
  outputText = File.read!(inputFile) 
  |> to_charlist 
  |> :lexer.string 
  |> elem(1) |> IO.inspect 
  |> addTags 
  outputText = "<html><head><link rel='stylesheet' href='styles.css'></head><code>#{outputText}</code></html>"
  IO.inspect(outputText)
  File.write!(outputFile, outputText)
end 
end
