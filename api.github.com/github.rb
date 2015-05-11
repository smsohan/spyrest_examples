require_relative '../spec_helper'

class Github
  include Spy

  base_uri 'https://api.github.com'
  headers('Accept' => 'application/vnd.github.v3+json',
    'User-Agent' => 'curl/7.37.1',
    'content-type' => 'application/json'
  )

  def self.auth_header
    {'Authorization' => "token #{ENV['GH_TOKEN']}"}
  end

end