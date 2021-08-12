#!/usr/bin/env ruby
require "stringio"

require "minitest/autorun"
require "minitest/reporters"
require "shoulda/context"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require "json_encoder/tokenizer"
require "json_encoder/parser"

module JsonEncoder
  class TestParser < Minitest::Test

    def parse(string)
      io = StringIO.new(string)
      tokenizer = Tokenizer.new(io)
      parser = Parser.new(tokenizer)
      return parser.parse.result
    end

    context "parser" do
      should "parse" do
        assert_equal true, true
      end

      should "parse top-level string" do
        assert_equal "Hello World", parse("Hello World")
      end
    end

  end
end