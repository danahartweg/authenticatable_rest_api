require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "#create" do
    post 'create', {
      user: {
        username: 'billy',
        name: 'Billy Blowers',
        email: 'billy_blowers@example.com',
        password: 'secret',
        password_confirmation: 'secret'
      }
    }
    results = JSON.parse(response.body)
    assert results['api_key']['access_token'] =~ /\S{32}/
    assert results['api_key']['user_id'] > 0
  end

  test "#create with invalid data" do
    post 'create', {
      user: {
        username: '',
        name: '',
        email: 'foo',
        password: 'secret',
        password_confirmation: 'something_else'
      }
    }
    results = JSON.parse(response.body)
    assert results['errors'].size == 3
  end

  test "#update" do
    dan = users(:dan)
    api_key = dan.session_api_key
    put 'update', {
      id: dan.id,
      user: {
        username: 'billy-new',
        name: 'New Billy',
        email: 'new-billy@example.com',
        password: 'new_secret',
        password_confirmation: 'new_secret'
      }
    }, { 'X-ACCESS-TOKEN' => "#{api_key.access_token}" }
    assert response.status == 200
  end

  test "#update, no password change" do
    dan = users(:dan)
    api_key = dan.session_api_key
    put 'update', {
      id: dan.id,
      user: {
        username: 'billy-new',
        name: 'New Billy',
        email: 'new-billy@example.com'
      }
    }, { 'X-ACCESS-TOKEN' => "#{api_key.access_token}" }
    assert response.status == 200
  end

  test "#show, valid token required" do
    dan = users(:dan)
    api_key = dan.session_api_key
    get 'show', { id: dan.id }, { 'X-ACCESS-TOKEN' => "#{api_key.access_token}" }
    results = JSON.parse(response.body)
    assert results['user']['id'] == dan.id
    assert results['user']['name'] == dan.name
  end

  test "#show, invalid token" do
    get 'show', { id: 2 }, { 'X-ACCESS-TOKEN' => "12345" }
    assert response.status == 401
  end

  test "#index, no token" do
    get 'index'
    assert response.status == 401
  end

  test "#index, invalid token" do
    get 'index', {}, { 'X-ACCESS-TOKEN' => "12345" }
    assert response.status == 401
  end

  test "#index, expired token" do
    dan = users(:dan)
    expired_api_key = dan.api_keys.session.create
    expired_api_key.update_attribute(:expired_at, 30.days.ago)
    assert !ApiKey.active.map(&:id).include?(expired_api_key.id)
    get 'index', {}, { 'X-ACCESS-TOKEN' => "#{expired_api_key.access_token}" }
    assert response.status == 401
  end

  test "#index, valid token required" do
    dan = users(:dan)
    api_key = dan.session_api_key
    get 'index', {}, { 'X-ACCESS-TOKEN' => "#{api_key.access_token}" }
    results = JSON.parse(response.body)
    assert results['users'].size == 2
  end
end
