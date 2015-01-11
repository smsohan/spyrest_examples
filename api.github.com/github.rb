require_relative '../spec_helper'

class Github
  include SpyRESTBase

  base_uri 'https://api.github.com'
  headers('Accept' => 'application/vnd.github.v3+json',
    'User-Agent' => 'curl/7.37.1',
    'Authorization' => "token #{ENV['GH_TOKEN']}"
  )
end