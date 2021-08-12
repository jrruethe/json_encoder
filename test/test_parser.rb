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

      should "parse top-level number" do
        assert_equal 1, parse("1")
      end

      should "parse object" do
        assert_equal ({key: "value"}), parse("*key.value+")
      end

      should "parse top-level array" do
        assert_equal [1, 2, 3], parse("-1.2.3+")
      end

      should "parse complex example" do
        truth =
        {
          one: "two",
          three: 4,
          five: 6.6,
          seven: [8, 8],
          nine:
          {
            ten: "eleven",
            twelve: 13,
            fourteen: 15.15,
            sixteen: [17, 17],
            eighteen:
            {
              nineteen: "twenty"
            }
          }
        }

        encoded = "*one.two.three.4.five.6$.6.seven.-8.8+.nine.*ten.eleven.twelve.13.fourteen.15$.15.sixteen.-17.17+.eighteen.*nineteen.twenty+++"

        assert_equal truth, parse(encoded)
      end
    end

  end
end