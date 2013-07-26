require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "#session" do
    dan = users(:dan)
    api_key = dan.find_api_key
    assert api_key.access_token =~ /\S{32}/
    assert api_key.user_id == dan.id
  end
end
