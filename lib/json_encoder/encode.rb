#!/usr/bin/env ruby

require "json"

require "json_encoder/escape"
require "json_encoder/structure"
require "json_encoder/optimizer"

module JsonEncoder

  class Encoder

    def self.encode(object)
      unpad(convert(optimize(normalize(object))))
    end

    private

    def self.normalize(object)
      case object
      when Hash;  return object.map{|k,v| [k.to_sym, normalize(v)]}.sort.to_h
      when Array; return object.map{|i| normalize(i)}
      else;       return object
      end
    end

    def self.optimize(object)
      Optimizer.optimize(object)
    end

    def self.convert(object, encoded="")
      case object
      when true;  encoded << "TRUE"
      when false; encoded << "FALSE"
      when nil;   encoded << "NULL"
      when String, Symbol, Integer, Float
        encoded << JsonEncoder::Escaper.escape(object.to_s)
      when Hash, Array
        object.traverse do |i|
          case i
          when JsonEncoder::Structure::StartObject; encoded << "*"
          when JsonEncoder::Structure::EndObject;   encoded << "+"
          when JsonEncoder::Structure::StartArray;  encoded << "-"
          when JsonEncoder::Structure::EndArray;    encoded << "+"
          when JsonEncoder::Structure::Separator;   encoded << "."
          else convert(i, encoded)
          end
        end
      end
      return encoded
    end

    def self.unpad(string)
      string = string[1..-1] if string.start_with?("*")
      string = string[0..-2] while string.end_with?("+")
      return string
    end

  end

end