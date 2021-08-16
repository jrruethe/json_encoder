#!/usr/bin/env ruby

module JsonEncoder
  class Optimizer

    def self.optimize(object)
      case object
      when Hash;  return object.map{|k,v| [k, optimize(v)]}.sort_by{|k,v| depth(v)}.to_h
      when Array; return object.map{|i| optimize(i)}
      else;       return object
      end
    end

    private

    def self.depth(object, level=0)
      case object
      when Hash
        object.each do |k,v|
          return depth(v, level+1)
        end
      when Array
        object.each do |i|
          return depth(i, level+1)
        end
      else
        return level
      end
    end
  end
end