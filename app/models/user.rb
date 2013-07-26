class User < ActiveRecord::Base
  has_secure_password
  has_many :api_keys

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :name, presence: true

  def find_api_key
    api_keys.api.first_or_create
  end
end
