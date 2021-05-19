lineEnding = (multilineString) ->
  if (multilineString.match(/\r\n/)) then '\r\n' else '\n'

isLine = (string) ->
  if string is "" then return false
  if /^\s+$/.test(string) then return false
  if /^\/\//.test(string) then return false
  return true

linesOfCode = (string) ->
  unblockedString = removeBlock string
  codeArray = unblockedString.split lineEnding(string)
  codeArray.map removeWhitespace
           .filter(isLine)
           .length

removeBlock = (string) ->
  BLOCK_QUOTE = /\/\*(.|\r?\n)*\*\//gm
  string.replace BLOCK_QUOTE, ""

isEmptyLine = (string) ->
  EMPTY_LINE = /^$/
  !!string.match EMPTY_LINE

removeWhitespace = (string) ->
  string.replace /^\s*/, ""

module.exports = {
  lineEnding
  isLine
  linesOfCode
  removeBlock
  isEmptyLine
  removeWhitespace
}
