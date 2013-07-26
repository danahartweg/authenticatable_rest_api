require 'test_helper'
require 'minitest/mock'

class ApiKeyTest < ActiveSupport::TestCase
  test "generates access token" do
    dan = users(:dan)
    api_key = ApiKey.create(scope: 'web', user_id: dan.id)
    assert !api_key.new_record?
    assert api_key.access_token =~ /\S{32}/
  end

  test "sets the expires_at properly for 'web' scope" do
    Time.stub :now, Time.at(0) do
      dan = users(:dan)
      api_key = ApiKey.create(scope: 'web', user_id: dan.id)

      assert api_key.expires_at == 1.day.from_now
    end
  end

  test "sets the expires_at properly for 'iOS' scope" do
    Time.stub :now, Time.at(0) do
      dan = users(:dan)
      api_key = ApiKey.create(scope: 'iOS', user_id: dan.id)

      assert api_key.expires_at == 30.days.from_now
    end
  end
end
