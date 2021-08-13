#!/usr/bin/env ruby

require "json"

require "json_encoder/escape"

module JsonEncoder

  class Encoder

    def self.encode(object)
      serialized = object.to_json
    end

    private

    def self.normalize(object)
      # TODO: Deep sort arrays and hashes by key
    end

    def self.stringify(object)
      # TODO: Transform all values into strings
    end

  end

end