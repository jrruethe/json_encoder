#!/usr/bin/env ruby

class String
  def cast
    return nil   if self == "null"
    return true  if self == "true"
    return false if self == "false"

    return self if start_with?("0")
    [
      :Integer,
      :Float
    ].each do |i|
      begin
        return Kernel.send(i, self)
      rescue
        next
      end
    end

    return self
  end
end

module JsonEncoder

  class Escaper

    def self.escape(string)
      string.gsub(/#{SYMBOLS}/, SYMBOL_ENCODER)
            .gsub(/([A-Z])/, "$\\1")
            .upcase
            .gsub(/[^A-Z0-9 $*\-+.]/, PERCENT_ENCODER)
    end

    def self.unescape(string)
      string.downcase
            .gsub(/\$([a-z])/){$1.upcase}
            .gsub(/(#{ENCODED_SYMBOLS})/, SYMBOL_DECODER)
            .gsub(/%\h\h/, PERCENT_DECODER)
            .cast
    end

    private

    SYMBOL_ENCODER =
    {
      "$" => "$$",
      "*" => "$*",
      "-" => "$-",
      "+" => "$+",
      "." => "$.",
      "#" => "$0",
      "&" => "$1",
      "," => "$2",
      "/" => "$3",
      ":" => "$4",
      ";" => "$5",
      "=" => "$6",
      "?" => "$7",
      "@" => "$8",
      "_" => "$9",
    }.freeze
    SYMBOLS = /[#{Regexp.escape(SYMBOL_ENCODER.keys.join)}]/
    SYMBOL_DECODER = SYMBOL_ENCODER.invert.freeze
    ENCODED_SYMBOLS = /\$[$*\-+.0-9]/

    # Adapted from:
    # https://github.com/ruby/ruby/blob/master/lib/uri/common.rb

    PERCENT_ENCODER = {} # :nodoc:
    256.times do |i|
      PERCENT_ENCODER[-i.chr] = -('%%%02X' % i)
    end
    PERCENT_ENCODER.freeze

    PERCENT_DECODER = {} # :nodoc:
    256.times do |i|
      h, l = i>>4, i&15
      PERCENT_DECODER[-('%%%X%X' % [h, l])] = -i.chr
      PERCENT_DECODER[-('%%%x%X' % [h, l])] = -i.chr
      PERCENT_DECODER[-('%%%X%x' % [h, l])] = -i.chr
      PERCENT_DECODER[-('%%%x%x' % [h, l])] = -i.chr
    end
    PERCENT_DECODER.freeze

  end

end