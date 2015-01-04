require 'rubygems'
require 'bundler/setup'
require 'httparty'

class Github
  include HTTParty

  base_uri 'https://api.github.com'

  host, port = ENV['REAL'] ? ['spyrest.com', 9081] : ['localhost', 9080]

  http_proxy host, port
  follow_redirects true
  headers('Accept' => 'application/vnd.github.v3+json', 'User-Agent' => 'curl/7.37.1')
end