require 'rubygems'
require 'bundler/setup'
require 'httparty'

require "minitest/autorun"

class Minitest::Spec
  before do
    description = (self.name =~ /^test_\d+_(.*)$/) && $1
    headers = {
      'x-spy-rest-desc' => description,
      'x-spy-rest-resource' => self.class.name.split("::").first
    }
    @common_options = {
      verify: false,
      headers: headers
    }
  end
end

module Spy

  def self.included(base)
    base.class_eval do
      include HTTParty
      host, port = ENV['REAL'] ? ['spyrest.com', 9081] : ['localhost', 9080]


      puts "XXX using proxy #{host} #{port}"

      http_proxy host, port
      follow_redirects true
      headers('User-Agent' => 'curl/7.37.1')
    end
  end

end