#!/usr/bin/env ruby

require "stringio"

require "json_encoder/tokenizer"
require "json_encoder/parser"

module JsonEncoder

  class Decoder

    def self.decode(string)
      parse(pad(string))
    end

    private

    def self.pad(string)
      so = count(string, "*")
      sa = count(string, "-")
      em = count(string, "+")
      string + ("+" * (so + sa - em))
    end

    def self.count(string, char)
      string.scan(/\$#{Regexp.escape(char)}|(#{Regexp.escape(char)})/).flatten.count(char)
    end

    def self.parse(string)
      io = StringIO.new(string)
      tokenizer = Tokenizer.new(io)
      parser = Parser.new(tokenizer)
      return parser.parse.result
    end

  end

end