require_relative "../spec_helper"

class LiquidPlanner
  include Spy

  base_uri 'https://app.liquidplanner.com/api'
  basic_auth 'sohan39@gmail.com', ENV['LIQUIDPLANNER_PASSWORD']

  headers(
    'User-Agent' => 'curl/7.37.1',
    'content-type' => 'application/json'
  )

end

describe 'Account' do

  it 'shows the account information for the API user' do
    response = LiquidPlanner.get '/account', @common_options
    assert_equal 200, response.code
  end

end

describe 'Workspace' do

  it 'shows the list of workspaces for the user' do
    response = LiquidPlanner.get '/workspaces', @common_options
    assert_equal 200, response.code
  end

end

describe 'Task' do

  it 'shows the list of tasks in a workspaces for the user' do
    response = LiquidPlanner.get '/workspaces/143500/tasks', @common_options
    assert_equal 200, response.code
  end

  it 'shows the list of upcoming tasks in a workspaces for the current user' do
    response = LiquidPlanner.get '/workspaces/143500/upcoming_tasks?limit=10', @common_options
    assert_equal 200, response.code
  end

  it 'shows the list of upcoming tasks in a workspaces for a different current user' do
    response = LiquidPlanner.get '/workspaces/143500/upcoming_tasks?limit=5&member_id=552590', @common_options
    assert_equal 200, response.code
  end

  it 'shows the list of tasks that are not done in a workspaces' do
    response = LiquidPlanner.get '/workspaces/143500/tasks?done=false', @common_options
    assert_equal 200, response.code
  end

  it 'allows the user to create a task' do
    task = {task: {name: "A sample task"}}

    response = LiquidPlanner.post '/workspaces/143500/tasks', @common_options.merge(body: task.to_json)
    assert_equal 201, response.code
  end

end

describe 'Treeitem' do

  it 'shows the list of treeitems in a workspaces for the user' do
    response = LiquidPlanner.get '/workspaces/143500/treeitems?depth=0', @common_options
    assert_equal 200, response.code
  end

  it 'shows the entire tree under a workspace' do
    response = LiquidPlanner.get '/workspaces/143500/treeitems?depth=-1&leaves=true', @common_options
    assert_equal 200, response.code
  end

end

describe 'Timesheet' do

  it 'shows the list of timesheets for a user' do
    response = LiquidPlanner.get '/workspaces/143500/timesheets?member_id=552590', @common_options
    assert_equal 200, response.code
  end

end