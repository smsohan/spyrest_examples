require_relative "../spec_helper"

class WordPressDirect
  include HTTParty
  base_uri 'http://wp.spyrest.com'
  basic_auth 'spyrest', ENV['WP_TOKEN']
end

class WordPress
  include Spy
  base_uri 'http://wp.spyrest.com'
end

class WordPessAuthed
  include Spy
  base_uri 'http://wp.spyrest.com'

  basic_auth 'spyrest', ENV['WP_TOKEN']
end


describe 'Posts' do
  let(:authed) do
    @common_options[:headers].merge!(WordPress.auth_header)
  end

  it 'Retrieve a single post' do
    post_options = @common_options.dup
    post_options[:headers].merge!('Content-Type' => 'application/json')

    body = JSON.generate({title: 'My Sample Post', content: 'This is a sample post content', status: 'publish'})
    post_options.merge!(body: body)
    response = WordPressDirect.post '/wp-json/wp/v2/posts', post_options
    refute_nil response.body
    assert_equal response.code, 201
    post_id = JSON.parse(response.body)['id']

    response = WordPress.get "/wp-json/wp/v2/posts/#{post_id}", @common_options
    assert_equal response.code, 200

    response = WordPressDirect.delete "/wp-json/wp/v2/posts/#{post_id}"
    assert_equal response.code, 200
  end

  it 'Show the first page of posts' do
    response = WordPress.get '/wp-json/wp/v2/posts', @common_options
    refute_nil response.body
    assert_equal response.code, 200
  end

  it 'Allows pagination' do
    response = WordPress.get '/wp-json/wp/v2/posts?page=1&per_page=1', @common_options
    refute_nil response.body
    assert_equal response.code, 200
  end

  it 'Find posts by a user' do
    response = WordPress.get '/wp-json/wp/v2/posts?user=1', @common_options
    refute_nil response.body
    assert_equal response.code, 200
  end

  it 'Filter posts by one or more IDs' do
    response = WordPress.get '/wp-json/wp/v2/posts?include[]=1&include[]=2', @common_options
    refute_nil response.body
    assert_equal response.code, 200
  end

  it 'List open posts' do
    response = WordPessAuthed.get '/wp-json/wp/v2/posts?status=open', @common_options
    refute_nil response.body
    assert_equal response.code, 200
  end

  it 'Create a post' do
    body = JSON.generate({title: 'My Sample Post', content: 'This is a sample post content', status: 'publish'})
    @common_options.merge!(body: body)
    @common_options[:headers].merge!('Content-Type' => 'application/json')
    response = WordPessAuthed.post '/wp-json/wp/v2/posts', @common_options
    refute_nil response.body
    assert_equal response.code, 201


    post_id = JSON.parse(response.body)['id']
    response = WordPressDirect.delete "/wp-json/wp/v2/posts/#{post_id}"
    assert_equal response.code, 200
  end

  it 'Update a post' do
    @common_options[:headers].merge!('Content-Type' => 'application/json')

    body = JSON.generate({title: 'My Sample Post', content: 'This is a sample post content'})
    @common_options.merge!(body: body)
    response = WordPressDirect.post '/wp-json/wp/v2/posts', @common_options
    refute_nil response.body
    assert_equal response.code, 201

    post_id = JSON.parse(response.body)['id']
    @common_options.merge!(body: {title: 'Updated title', content: 'Updated content'})
    response = WordPessAuthed.post "/wp-json/wp/v2/posts/#{post_id}", @common_options

    assert_equal response.code, 200

    response = WordPressDirect.delete "/wp-json/wp/v2/posts/#{post_id}"
    assert_equal response.code, 200
  end

  it 'Delete a post' do
    @common_options[:headers].merge!('Content-Type' => 'application/json')

    body = JSON.generate({title: 'My Sample Post', content: 'This is a sample post content'})
    @common_options.merge!(body: body)
    response = WordPressDirect.post '/wp-json/wp/v2/posts', @common_options
    refute_nil response.body
    assert_equal response.code, 201
    post_id = JSON.parse(response.body)['id']

    response = WordPessAuthed.delete "/wp-json/wp/v2/posts/#{post_id}", @common_options
    assert_equal response.code, 200
  end

end

