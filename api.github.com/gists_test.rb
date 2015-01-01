require 'rubygems'
require 'bundler/setup'

require "minitest/autorun"
require_relative 'github'

describe 'gists' do
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

  it "List a user's gists since a time:" do
    response = Github.get '/users/smsohan/gists?since=20140101T00:00:00Z', @common_options
    assert_equal 200, response.code
    refute_nil response.body
  end

  it "List a user's gists" do
    response = Github.get '/users/smsohan/gists', @common_options
    assert_equal 200, response.code
    refute_nil response.body
  end

  it "List all public gists" do
    response = Github.get '/gists/public', @common_options
    assert_equal 200, response.code
    refute_nil response.body
  end

end

