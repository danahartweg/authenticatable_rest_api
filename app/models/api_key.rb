class ApiKey < ActiveRecord::Base
  validates :scope, inclusion: { in: %w( session api ) }
  before_create :generate_access_token, :set_expiry_date
  belongs_to :user

  scope :session, -> { where(scope: 'session') }
  scope :api,     -> { where(scope: 'api') }

  def set_expiry_date
    self.expires_at = if self.scope == 'api'
                        2.days.from_now
                      else
                        4.hours.from_now
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
