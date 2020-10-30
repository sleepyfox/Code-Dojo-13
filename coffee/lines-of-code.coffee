isLine = (string) ->
  if string is "" then return false
  if /^\s+$/.test(string) then return false
  if /^\/\//.test(string) then return false
  return true

linesOfCode = (string) ->
  string = removeWhitespace removeEmptyLines removeBlock string
  codeArray = string.split "\n"
  codeArray.filter(isLine).length

removeBlock = (string) ->
  BLOCK_QUOTE = /\/\*(.|\n)*\*\//gm
  string.replace BLOCK_QUOTE, ""

removeEmptyLines = (string) ->
  EMPTY_LINE = /\n[\n]+/g
  string.replace EMPTY_LINE, "\n"

removeWhitespace = (string) ->
  string.replace /^\s*\n/gm, ""

module.exports = { isLine, linesOfCode, removeBlock, removeEmptyLines, removeWhitespace }
