#!/usr/bin/env ruby

module JsonEncoder
  class Tokenizer
    STRING = /.*/
    NUMBER = /-?(?:0|[1-9]\d*)(?:\.\d+)?(?:[eE][+-]?\d+)?/
    TRUE   = /true/
    FALSE  = /false/
    NULL   = /null/

    def initialize io
      @ss = StringScanner.new io.read
    end

    def next_token
      return if @ss.eos?

      case
      when text = @ss.scan(STRING) ; [:STRING, text]
      when text = @ss.scan(NUMBER) ; [:NUMBER, text]
      when text = @ss.scan(TRUE)   ; [:TRUE,   text]
      when text = @ss.scan(FALSE)  ; [:FALSE,  text]
      when text = @ss.scan(NULL)   ; [:NULL,   text]
      else
        x = @ss.getch
        [x, x]
      end
    end
  end
end