require 'rubygems'
require 'bundler/setup'

require "minitest/autorun"
require_relative 'github'

describe "Github/search" do

  describe 'Search repositories' do

    it 'Suppose you want to search for popular Tetris repositories written in Assembly. Your query might look like this.' do
      response = Github.get '/search/repositories?q=tetris+language:assembly&sort=stars&order=desc',
        verify: false,
        headers: {
          'x-spy-rest-desc' =>'Suppose you want to search for popular Tetris repositories written in Assembly. Your query might look like this.',
          'x-spy-rest-resource' => 'search'
        }
      assert_equal 200, response.code
      refute_nil response.body
    end
  end

end
