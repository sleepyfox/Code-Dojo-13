should = require('chai').should()
fs = require 'fs'
loc = require './lines-of-code'

threeLines = fs.readFileSync('./3-lines.java', 'utf8')
fiveLines = fs.readFileSync('./5-lines.java', 'utf8')

describe 'line counter', ->
  describe 'checking a line of code', ->
    it 'a line containing only whitespace should not count', ->
      loc.isLine(" ").should.equal false

    it 'a blank line should not count as a line', ->
      loc.isLine("").should.equal false

    it 'a line that is not blank should be a line', ->
      loc.isLine("public interface Dave {").should.equal true

    it 'a line starting with a double slash should not count', ->
      loc.isLine("//a").should.equal false

    it 'a line containing non whitespace before a comment should be a line', ->
      loc.isLine("a//b").should.equal true

  describe 'Block comments', ->
    it 'a file containing a block comment should have it removed', ->
      loc.removeBlock("a/*\nb\n*/c").should.equal "ac"

  describe 'Empty lines', ->
    it 'a file containing two empty lines should have them reduced to one', ->
      loc.removeEmptyLines("a\n\nb").should.equal "a\nb"

    it 'a file containing three empty lines should have them reduced to one', ->
      loc.removeEmptyLines("a\n\n\nb").should.equal "a\nb"

    it 'a file containing four empty lines should have them reduced to one', ->
      loc.removeEmptyLines("a\n\n\n\nb").should.equal "a\nb"

  describe 'Whitespace', ->
    it 'a line containing nothing by whitespace should be replaced by a blank line', ->
      loc.removeWhitespace("a\n \nb").should.equal "a\nb"

    it 'leading whitespace should be removed', ->
      loc.removeWhitespace("  \t  \n \nb").should.equal "b"

  describe 'Calculating the number of lines', ->
    it 'a file with 2 lines of code should have two lines', ->
      loc.linesOfCode("jdhfgfdjg\nkdhfghdfg").should.equal 2

    it 'any line between a block comment start and end should not count', ->
      loc.linesOfCode("/*gjhadsgh\njhgjhg\nfgdgfdgf*/").should.equal 0
  
    it 'a block comment\'s new lines should not be counted', ->
      loc.linesOfCode("a/*\nb\n*/c").should.equal 1
  
    # remove block quotes, remove empty lines, remove blank lines, count what's left
    it 'tests perverse case', ->
      loc.linesOfCode("        System./*wait*/out./*for*/println/*it*/(\"Hello/*\");").should.equal 1

    xit 'tests 3-line-file', ->
      loc.linesOfCode(threeLines).should.equal 3

    xit 'tests 5-line-file', ->
      loc.linesOfCode(fiveLines).should.equal 5
