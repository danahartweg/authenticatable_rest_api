class ApiKey < ActiveRecord::Base
  validates :scope, inclusion: { in: %w( web iOS ) }
  before_create :generate_access_token, :set_expiry_date
  belongs_to :user

  scope :web, -> { where(scope: 'web') }
  scope :iOS,     -> { where(scope: 'iOS') }

  def set_expiry_date
    self.expires_at = if self.scope == 'iOS'
                        30.days.from_now
                      else
                        1.day.from_now
                      end
  end

  def generate_access_token
    begin
      self.access_token = SecureRandom.hex
    end while self.class.exists?(access_token: access_token)
  end

  def is_expired
    return self.expires_at <= Time.now ? true : false
  end
end
