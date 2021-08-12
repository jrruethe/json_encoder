class JsonEncoder::Parser

token STRING NUMBER TRUE FALSE NULL

rule
  document
    : object
    | array
    | value
  ;
  object
    : start_object end_object
    | start_object pairs end_object
  ;
  start_object
    : "*" {@handler.start_object}
  ;
  end_object
    : "+" {@handler.end_object}
  ;
  pairs
    : pairs "," pair
    | pair
  ;
  pair
    : string ":" value
  ;
  array
    : start_array end_array
    | start_array values end_array
  ;
  start_array
    : "-" {@handler.start_array}
  ;
  end_array
    : "+" {@handler.end_array}
  ;
  values
    : values "," value
    | value
  ;
  value
    : scalar
    | object
    | array
  ;
  scalar
    : string
    | literal {@handler.scalar(val[0])}
  ;
  string
    : STRING {@handler.scalar(val[0])}
  ;
  literal
    : NUMBER {n = val[0]; result = n.include?(".") ? n.to_f : n.to_i}
    | TRUE   {result = true}
    | FALSE  {result = false}
    | NULL   {result = nil}
  ;

end

---- inner

require "json_encoder/handler"

attr_reader :handler

def initialize(tokenizer, handler = Handler.new)
  @tokenizer = tokenizer
  @handler   = handler
  super()
end

def next_token
  @tokenizer.next_token
end

def parse
  do_parse
  handler
end