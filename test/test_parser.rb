#!/usr/bin/env ruby
require "minitest/autorun"
require "minitest/reporters"
require "shoulda/context"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestParser < Minitest::Test

  context "parser" do
    should "parse" do
      assert_equal true, true
    end
  end

end