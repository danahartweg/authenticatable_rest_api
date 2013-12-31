require 'spec_helper'

describe User do
	it "has a valid factory" do
		create(:user).should be_valid
	end

	it "is invalid without a name" do
		build(:user, name: nil).should_not be_valid
	end

	it "is invalid without a username" do
		build(:user, username: nil).should_not be_valid
	end

	it "is invalid without an email address" do
		build(:user, email: nil).should_not be_valid
	end

	it "is invalid without a password and password confirmation" do
		build(:user, password: nil, password_confirmation:nil).should_not be_valid
	end

	it "must have a unique username" do
		create(:user, username: 'testusername')
		build(:user, username: 'testusername').should_not be_valid
	end

	it "must have a unique email address" do
		create(:user, email: 'test@example.com')
		build(:user, email: 'test@example.com').should_not be_valid
	end

	it "returns it's associated api key" do
		user = create(:user)
		api_key = user.find_api_key

		api_key.access_token.should =~ /\S{32}/
		api_key.user_id.should == user.id
	end
end
