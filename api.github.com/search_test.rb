require 'rubygems'
require 'bundler/setup'

require "minitest/autorun"
require_relative 'github'

describe "search" do

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

  describe 'repositories' do
    it 'Suppose you want to search for popular Tetris repositories written in Assembly. Your query might look like this.' do
      response = Github.get '/search/repositories?q=tetris+language:assembly&sort=stars&order=desc', @common_options
      assert_equal 200, response.code
      refute_nil response.body
    end
  end

  describe 'Search code' do
    it 'Suppose you want to find the definition of the addClass function inside jQuery. Your query would look something like this:' do
      response = Github.get '/search/code?q=addClass+in:file+language:js+repo:jquery/jquery', @common_options
      assert_equal 200, response.code
      refute_nil response.body
    end
  end

end
