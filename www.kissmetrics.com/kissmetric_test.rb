require_relative '../spec_helper'

class KissMetrics
  include Spy
  base_uri 'https://api.kissmetrics.com'

  def self.auth_header
    {'Authorization' => "Bearer #{ENV['KISS_METRICS_KEY']}"}
  end

  def self.get_with_auth(url, options)
    options[:headers].merge!(KissMetrics.auth_header)

    get url, options
  end

end

describe 'Root' do
  it 'The root directory returns a list of all available links within the API.' do
    response = KissMetrics.get_with_auth '/core', @common_options
    refute_nil response.body
  end
end

describe 'Account' do
  it 'The accounts endpoint returns a list of accounts you are authorized to access.' do
    response = KissMetrics.get_with_auth '/core/accounts', @common_options
    refute_nil response.body
  end

  it 'The account endpoint returns the body of the account you are authorized to access.' do
    response = KissMetrics.get_with_auth '/core/accounts/44424650-7e6d-0132-7ec1-22000ab4dcd7', @common_options
    refute_nil response.body
  end
end

describe 'Product' do
  it 'The products endpoint returns a collection of all products you have access to. If you are a member of multiple Accounts, then you will see all products across those accounts.' do
    response = KissMetrics.get_with_auth '/core/products', @common_options
    refute_nil response.body
  end

  it 'The product endpoint returns the body of the product you are authorized to access.' do
    response = KissMetrics.get_with_auth '/core/products/44e90cb0-7e6d-0132-70b8-22000a9a8afc', @common_options
    refute_nil response.body
  end
end

describe 'Report' do
  it 'The reports endpoint returns a list of reports you are authorized to access. This includes all Reports across all Products.' do
    response = KissMetrics.get_with_auth '/core/reports?limit=20&offset=0', @common_options
    refute_nil response.body
  end

  it 'The reports endpoint allows you to paginate' do
    response = KissMetrics.get_with_auth '/core/reports?limit=20&offset=20', @common_options
    refute_nil response.body
  end
end

describe 'Event' do
  it 'The events endpoint returns a list of events from your event libraries. This includes all Events across all Products.' do
    response = KissMetrics.get_with_auth '/core/events?limit=20&offset=0', @common_options
    refute_nil response.body
  end
end

