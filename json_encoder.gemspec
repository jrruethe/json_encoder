#!/usr/bin/env ruby
# frozen_string_literal: true
require "yaml"
metadata = YAML.load_file(File.join(__dir__, "Gemspec.yml"))

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "json_encoder/version"

Gem::Specification.new do |spec|
  spec.version = JsonEncoder::VERSION
  metadata.each do |k,v|
    spec.send("#{k.to_sym}=", v)
  end
  spec.files = Dir.glob("{lib,bin}/**/*", File::FNM_DOTMATCH)

  spec.executables =
  [
    "json_encoder"
  ]

  spec.add_dependency "racc"

  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "minitest-reporters"
  spec.add_development_dependency "shoulda-context"
  spec.add_development_dependency "pry"
end
