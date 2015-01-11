require_relative 'github'

describe 'Notifications' do

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

end