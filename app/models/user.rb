class User < ActiveRecord::Base
  has_secure_password
  has_many :api_keys

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :name, presence: true

  # default to the web scope if none is provided
  def find_api_key (targetScope = 'web')
    self.api_keys.where(scope: targetScope).first_or_create
  end
end
