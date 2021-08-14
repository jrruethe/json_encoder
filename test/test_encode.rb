#!/usr/bin/env ruby

require "minitest/autorun"
require "minitest/reporters"
require "shoulda/context"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require "json_encoder"

module JsonEncoder

  class TestEncoder < Minitest::Test

    context "encoder" do

      should "encode strings" do

      end

      should "encode integers" do

      end

      should "encode floats" do

      end

      should "encode true" do

      end

      should "encode false" do

      end

      should "encode nil" do

      end

      should "encode objects" do

      end

      should "encode arrays" do

      end

      should "encode complex objects" do

      end

      should "encode escaped strings" do

      end

      should "encode urls" do

      end

      should "decode 0-prefixed integers as strings" do

      end

      should "decode negative integers" do

      end

      should "decode negative floats" do

      end

    end

  end

end