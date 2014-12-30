require 'rubygems'
require 'bundler/setup'

require "minitest/autorun"
require_relative 'github'

describe "Github/search" do
  describe 'search for user' do
    it "searches for a user by name" do
      response = Github.get '/users/smsohan/repos', verify: false
      # assert_equals response.response.body, 200
    end
  end
end
