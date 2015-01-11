require_relative 'github'

describe 'Notifications' do

  before do
    @common_options[:headers].merge!(Github.auth_header)
  end

  it 'List all unread notifications for the current user, grouped by repository.' do
    response = Github.get '/notifications', @common_options
    assert_equal 200, response.code
  end

  it 'List all notifications including read ones for the current user, grouped by repository.' do
    response = Github.get '/notifications?all=true', @common_options
    assert_equal 200, response.code
  end

  it 'List notifications only where the current user is directly participating or mentioned' do
    response = Github.get '/notifications?participating=true', @common_options
    assert_equal 200, response.code
  end

  it 'List notifications since a time' do
    response = Github.get '/notifications?since=2014-01-01T00:00:00Z', @common_options
    assert_equal 200, response.code
  end

  it 'List your notifications in a repository' do
    response = Github.get '/repos/smsohan/mvcmailer/notifications', @common_options
    assert_equal 200, response.code
  end

  it 'Mark notifications as read in a repository' do
    response = Github.put '/repos/smsohan/mvcmailer/notifications',
      @common_options.merge(body: {}.to_json)
    assert_equal 205, response.code
  end

  it 'View a single thread' do
    response = Github.get '/notifications/threads/35582591', @common_options
    assert_equal 200, response.code
  end

  it 'Get a Thread Subscription' do
    response = Github.get '/notifications/threads/35582591/subscription', @common_options
    assert_equal 200, response.code
  end

  it 'Set a Thread Subscription' do
    response = Github.put '/notifications/threads/35582591/subscription', @common_options.merge(body: {}.to_json)
    assert_equal 200, response.code
  end

  it 'Delete a Thread Subscription' do
    response = Github.delete '/notifications/threads/35582591/subscription', @common_options.merge(body: {}.to_json)
    assert_equal 204, response.code
  end

end