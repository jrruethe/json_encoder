#!/usr/bin/env ruby

# Adapted from:
# https://github.com/tenderlove/rjson/blob/master/lib/rjson/tokenizer.rb

require "json_encoder/escape"

module JsonEncoder
  class Tokenizer
    INTEGER = /(\$-)?[1-9][0-9]*/
    FLOAT   = /(\$-)?[1-9][0-9]*\$\.[0-9]*/
    TRUE    = /TRUE/
    FALSE   = /FALSE/
    NULL    = /NULL/
    STRING  = /(\$?[A-Z]|\$?[0-9]|\$[*\-+.]|[% ])+/

    def initialize(io)
      @ss = StringScanner.new(io.read)
    end

    def next_token
      return if @ss.eos?
      case
      # when text = @ss.scan(FLOAT)   ; [:FLOAT,   text.gsub("$", "")]
      # when text = @ss.scan(INTEGER) ; [:INTEGER, text.gsub("$", "")]
      when text = @ss.scan(TRUE)    ; [:TRUE,    text]
      when text = @ss.scan(FALSE)   ; [:FALSE,   text]
      when text = @ss.scan(NULL)    ; [:NULL,    text]
      when text = @ss.scan(STRING)  ; [:STRING,  JsonEncoder.unescape(text)]
      else
        x = @ss.getch
        return [x, x]
      end
    end
  end
end