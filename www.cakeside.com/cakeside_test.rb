require_relative "../spec_helper"

class Cakeside
  include Spy
  base_uri 'https://www.cakeside.com'
end

describe 'cakes' do
  it 'shows the first page of cakes by default' do
    response = Cakeside.get '/api/v2/cakes.json', @common_options
    refute_nil response.body
  end
  it 'shows page 2 of cakes when the page parameter is 2' do
    response = Cakeside.get '/api/v2/cakes.json?page=2', @common_options
    refute_nil response.body
  end
end

describe 'photos' do
  it 'shows the first page of photos by default' do
    response = Cakeside.get '/api/v2/photos.json', @common_options
    refute_nil response.body
  end
  it 'shows page 2 of photos when the page parameter is 2' do
    response = Cakeside.get '/api/v2/photos.json?page=2', @common_options
    refute_nil response.body
  end
end

describe 'users' do
  it 'shows the first page of users by default' do
    response = Cakeside.get '/api/v2/users.json', @common_options
    refute_nil response.body
  end
  it 'shows page 2 of users when the page parameter is 2' do
    response = Cakeside.get '/api/v2/users.json?page=2', @common_options
    refute_nil response.body
  end
end

