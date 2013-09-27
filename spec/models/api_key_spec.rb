require 'spec_helper'

describe ApiKey do

	it "has a valid factory" do
		FactoryGirl.create(:api_key).should be_valid
	end

	it "knows when it expires" do
		api_key = FactoryGirl.create(:api_key)
		api_key.expires_at.should be_a(Time)
	end

	it "generates an access token" do
		FactoryGirl.create(:api_key).access_token.should =~ /\S{32}/
	end

	it "must accept web or iOS as a scope" do
		FactoryGirl.create(:api_key).scope.should be_in %w( web iOS )
	end

	it "shouldn't accept scopes other than web or iOS" do
		FactoryGirl.build(:api_key, scope: 'badScope').should_not be_valid
	end

	it "sets expiration properly for the web scope" do
		api_key = FactoryGirl.build(:api_key, scope: 'web')
		api_key.set_expiry_date
		api_key.expires_at.should be_within(1.second).of(1.day.from_now)
	end

	it "sets expiration properly for the iOS scope" do
		api_key = FactoryGirl.build(:api_key, scope: 'iOS')
		api_key.set_expiry_date
		api_key.expires_at.should be_within(1.second).of(30.days.from_now)
	end

	it "is associated with a user" do
		api_key = FactoryGirl.create(:api_key)
		api_key.user = FactoryGirl.create(:user)
		api_key.user.should be_valid
	end

	it "can be expired" do
		api_key = FactoryGirl.build(:api_key, expires_at: 60.days.from_now)
		api_key.is_expired.should == false
	end

end
