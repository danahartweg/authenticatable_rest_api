require 'spec_helper'

describe SessionController do

	describe "POST #create" do
		it "authenticates with a username" do
			user = FactoryGirl.create(:user)
			post :create, { username_or_email: user.username, password: user.password }
			results = JSON.parse(response.body)

			results['api_key']['access_token'].should =~ /\S{32}/
			results['api_key']['user_id'].should == user.id
		end

		it "authenticates with an email address" do
			user = FactoryGirl.create(:user)
			post :create, { username_or_email: user.email, password: user.password }
			results = JSON.parse(response.body)

			results['api_key']['access_token'].should =~ /\S{32}/
			results['api_key']['user_id'].should == user.id
		end

		it "doesn't authenticate with invalid user information" do
			user = FactoryGirl.create(:user)
			post :create, { username_or_email: user.email, password: 'definitelyWrongPassword' }

			response.status.should == 401
		end
	end

	describe "DELETE #destroy" do
		it "destroys the access token upon logout" do
			user = FactoryGirl.create(:user)
			api_key = user.find_api_key
			delete :destroy, {}, { 'X-ACCESS-TOKEN' => "#{api_key.access_token}" }

			response.status.should == 200
		end
	end

end
