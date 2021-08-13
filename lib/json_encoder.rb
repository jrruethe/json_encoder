#!/usr/bin/env ruby

require "stringio"

require "json_encoder/encode"
require "json_encoder/decode"

module JsonEncoder

  def self.encode(object)
    Encoder.encode(object)
  end

  def self.decode(string)
    Decoder.decode(string)
  end
  
end