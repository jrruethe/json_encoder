#!/usr/bin/env ruby

# Adapted from:
# https://github.com/tenderlove/rjson/blob/master/lib/rjson/handler.rb

module JsonEncoder
  class Handler

    def initialize
      @stack = [[:root]]
    end

    def start_object
      push([:hash])
    end

    def start_array
      push([:array])
    end

    def end_object
      @stack.pop
    end
    alias :end_array :end_object

    def scalar(object)
      @stack.last << [:scalar, object]
    end

    def result
      root = @stack.first.last
      process(root.first, root.drop(1))
    end

    private

    def push(object)
      @stack.last << object
      @stack << object
    end

    def process type, rest
      case type
      when :hash
        t = rest.map{|i| process(i.first, i.drop(1))}
        t = t.each_slice(2).to_a.map{|(k,v)| [k.to_sym, v]}
        Hash[t]
      when :array
        rest.map{|i| process(i.first, i.drop(1))}
      when :scalar
        rest.first
      end
    end
  end
end
