should = require('chai').should()

isLine = (string) ->
  if string is "" then return false

  regexp = /\s+/
  if regexp.test(string) then return false

  regexp = /^\/\//
  if regexp.test(string) then return false
  return true

removeBlock = (string) ->
  BLOCK_QUOTE = /\/\*(.|\n)*\*\//gm
  string.replace BLOCK_QUOTE, "\n"

linesOfCode = (string) ->
  string = removeBlock string
  array = string.split "\n"
  lines = 0
  for line in array
    if isLine line
      lines++
  return lines

removeEmptyLines = (string) ->
  EMPTY_LINE = /\n[\n]+/g
  string.replace EMPTY_LINE, "\n"

removeWhitespace = (string) ->
  string.replace /^\s*\n/gm, ""

describe 'line counter', ->
  it 'a line containing only whitespace should not count', ->
    isLine(" ").should.equal false

  it 'a blank line should not count as a line', ->
    isLine("").should.equal false

  it 'a line that is not blank should be a line', ->
    isLine("a").should.equal true

  it 'a line starting with a double slash should not count', ->
    isLine("//a").should.equal false

  it 'a line containing non whitespace before a comment should be a line', ->
    isLine("a//b").should.equal true

  it 'a file with 2 lines of code should have two lines', ->
    linesOfCode("jdhfgfdjg\nkdhfghdfg").should.equal 2

  it 'any line between a block comment start and end should not count', ->
    linesOfCode("/*gjhadsgh\njhgjhg\nfgdgfdgf*/").should.equal 0

  it 'a file containing a block comment should have it removed', ->
    removeBlock("a/*\nb\n*/c").should.equal "a\nc"

  it 'a file containing nothing other than a block comment should have no lines of code', ->
    linesOfCode("a/*\nb\n*/c").should.equal 2

  it 'a file containing two empty lines should have them reduced to one', ->
    removeEmptyLines("a\n\nb").should.equal "a\nb"

  it 'a file containing three empty lines should have them reduced to one', ->
    removeEmptyLines("a\n\n\nb").should.equal "a\nb"

  it 'a file containing four empty lines should have them reduced to one', ->
    removeEmptyLines("a\n\n\n\nb").should.equal "a\nb"

  it 'a line containing nothing by whitespace should be replaced by a blank line', ->
    removeWhitespace("a\n \nb").should.equal "a\nb"

  it 'a line containing nothing by whitespace should be replaced by a blank line', ->
    removeWhitespace("  \t  \n \nb").should.equal "b"

# remove block quotes, remove empty lines, remove blank lines, count what's left
