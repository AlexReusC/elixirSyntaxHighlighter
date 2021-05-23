defmodule ElixirLexer do
  def addTags(list) do
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
            :unicodePoint ->
              "<a style='color:#2a6edb;'>#{chars}</a>"
            :atom ->
              "<a style='color:aquamarine;'>#{chars}</a>"
            :singleQuotedAtom ->
              "<a style='color:aquamarine;'>#{chars}</a>"
            :dobleQuotedAtom ->
              "<a style='color:aquamarine;'>#{chars}</a>"
            :keywordAtom ->
              "<a style='color:#2a6edb;'>#{chars}</a>"
            :string ->
              "<a style='color:greenyellow;'>#{chars}</a>"
            :multilineString ->
              "<a style='color:greenyellow;'>#{chars}</a>"
            :charlist ->
              "<a style='color:greenyellow;'>#{chars}</a>"
            :multilineCharlist ->
              "<a style='color:greenyellow;'>#{chars}</a>"
            :delimiter ->
              "<a style='color:red;'>#{chars}</a>"
            :variable ->
              "<a style='color:sandybrown;'>#{chars}</a>"
            :hiddenVariable ->
              "<a style='color:grey;'>#{chars}</a>"
            :alias ->
              "<a style='color:gold;'>#{chars}</a>"
            :comment ->
              "<a style='color:grey;'>#{chars}</a>"
            :newline ->
              "<div>\n</div>"
            :skip ->
              "<a>#{chars}</a>"
            :reservedAtom ->
              "<a style='color:green;'>#{chars}</a>"
            :reservedOperator ->
              "<a style='color:violet;'>#{chars}</a>"
            :reservedFn ->
              "<a style='color:violet;'>#{chars}</a>"
            :reservedBlock ->
              "<a style='color:violet;'>#{chars}</a>"
            :reservedGeneral ->
              "<a style='color:violet;'>#{chars}</a>"
            :operator ->
            "<a style='color:red;'>#{chars}</a>"    
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
