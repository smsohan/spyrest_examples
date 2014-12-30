require 'rubygems'
require 'bundler/setup'
require 'httparty'

class Github
  include HTTParty

  base_uri 'https://api.github.com'
  http_proxy 'spyrest.com', 9081
  follow_redirects true
  headers('Accept' => 'application/vnd.github.v3+json', 'User-Agent' => 'curl/7.37.1')
end