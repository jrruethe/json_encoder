#!/usr/bin/env ruby

module JsonEncoder
  module Structure
    class StartObject; end
    class EndObject;   end
    class StartArray;  end
    class EndArray;    end
    class Separator;   end

    START_OBJECT = StartObject.new
    END_OBJECT   = EndObject.new
    START_ARRAY  = StartArray.new
    END_ARRAY    = EndArray.new
    SEPARATOR    = Separator.new

    def self.traverse(object, &block)
      case object
      when Hash
        yield START_OBJECT;
        object.each_with_index do |(k,v), n|
          yield SEPARATOR unless n == 0
          yield k
          yield SEPARATOR
          self.traverse(v, &block)
        end
        yield END_OBJECT
      when Array
        yield START_ARRAY
        object.each_with_index do |i, n|
          yield SEPARATOR unless n == 0
          self.traverse(i, &block)
        end
        yield END_ARRAY
      else
        yield object
      end
    end
  end
end

class Hash
  def traverse(&block)
    JsonEncoder::Structure.traverse(self, &block)
  end
end

class Array
  def traverse(&block)
    JsonEncoder::Structure.traverse(self, &block)
  end
end