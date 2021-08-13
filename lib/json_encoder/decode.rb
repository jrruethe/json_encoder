#!/usr/bin/env ruby

require "stringio"

require "json_encoder/tokenizer"
require "json_encoder/parser"

module JsonEncoder

  class Decoder

    def self.decode(string)
      parse(pad(prefix(string)))
    end

    private

    def self.prefix(string)
      if count(string, ".") > 0   &&
         !string.start_with?("-") &&
         !string.start_with?("*")
        return "*" + string
      end
      return string
    end

    def self.pad(string)
      so = count(string, "*")
      sa = count(string, "-")
      em = count(string, "+")
      string + ("+" * (so + sa - em))
    end

    def self.count(string, char)
      c = Regexp.escape(char)
      string.scan(/\$#{c}|(#{c})/).flatten.count(char)
    end

    def self.parse(string)
      io = StringIO.new(string)
      tokenizer = Tokenizer.new(io)
      parser = Parser.new(tokenizer)
      return parser.parse.result
    end

  end

end