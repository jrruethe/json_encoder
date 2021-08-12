#!/usr/bin/env ruby

module JsonEncoder
  class Tokenizer
    STRING  = /[a-zA-Z ]+/
    INTEGER = /($-)?[1-9][0-9]*/
    FLOAT   = /($-)?[1-9][0-9]*\$\.[0-9]*/
    TRUE    = /true/
    FALSE   = /false/
    NULL    = /null/

    def initialize io
      @ss = StringScanner.new io.read
    end

    def next_token
      return if @ss.eos?
      case
      when text = @ss.scan(FLOAT)   ; [:FLOAT,   text.gsub("$", "")]
      when text = @ss.scan(INTEGER) ; [:INTEGER, text]
      when text = @ss.scan(TRUE)    ; [:TRUE,    text]
      when text = @ss.scan(FALSE)   ; [:FALSE,   text]
      when text = @ss.scan(NULL)    ; [:NULL,    text]
      when text = @ss.scan(STRING)  ; [:STRING,  text]
      else
        x = @ss.getch
        [x, x]
      end
    end
  end
end