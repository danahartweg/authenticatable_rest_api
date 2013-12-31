require 'faker'

FactoryGirl.define do
	factory :api_key do
		access_token SecureRandom.hex
		scope "web"
	end
end
