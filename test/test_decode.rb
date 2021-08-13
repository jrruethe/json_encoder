#!/usr/bin/env ruby

require "minitest/autorun"
require "minitest/reporters"
require "shoulda/context"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require "json_encoder"

module JsonEncoder

  class TestDecoder < Minitest::Test

    context "decoder" do

      should "decode strings" do
        assert_equal "Hello World", JsonEncoder.decode("Hello World")
      end

      should "decode integers" do
        assert_equal 123, JsonEncoder.decode("123")
      end

      should "decode floats" do
        assert_equal 11.22, JsonEncoder.decode("11$.22")
      end

      should "decode true" do
        assert_equal true, JsonEncoder.decode("true")
      end

      should "decode false" do
        assert_equal false, JsonEncoder.decode("false")
      end

      should "decode nil" do
        assert_nil JsonEncoder.decode("null")
      end

      should "decode objects" do

      end

      should "decode arrays" do

      end

      should "decode complex objects" do

      end

      should "decode escaped strings" do

      end

      should "decode percent-encoded strings" do

      end

      should "decode complex strings" do

      end

      should "decode urls" do

      end

      should "decode 0-prefixed integers as strings" do
        assert_equal "0123", JsonEncoder.decode("0123")
      end

      should "decode negative integers" do
        assert_equal -123, JsonEncoder.decode("$-123")
      end

      should "decode negative floats" do
        assert_equal -11.22, JsonEncoder.decode("$-11$.22")
      end

    end

  end

end