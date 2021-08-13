#!/usr/bin/env ruby

module JsonEncoder

  def self.escape(string)
    string
  end

  def self.unescape(string)
    string.downcase.gsub(/\$([a-z])/){$1.upcase}
  end

end