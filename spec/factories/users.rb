require 'faker'

FactoryGirl.define do
	factory :user do
		name { Faker::Name.name }
		username { Faker::Internet.user_name }
		email { Faker::Internet.email }
		password "password"
		password_confirmation "password"

    factory :admin do
      admin true
    end
    
	end
end
