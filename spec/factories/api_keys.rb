require 'faker'

FactoryGirl.define do
	factory :api_key do |f|
		f.access_token SecureRandom.hex
		f.scope "web"
	end
end
