require 'spec_helper'

describe SessionController do

	let(:user) { create(:user) }

	describe "with valid token", validToken: true do
		before(:each) { authWithUser(user) }
		let(:api_key) { user.find_api_key }

		describe "POST #create" do
			before(:each) { post :create }

			it "has an error message" do
				expect(json).to have_key('errors')
			end

			it { should respond_with 401 }			
		end

		describe "DELETE #destroy" do
			before :each do
				delete :destroy
				api_key.reload
			end

			it "clears the access token" do
				expect(api_key.access_token).to eq('')
			end

			it "expires the api_key" do
				expect(api_key.expires_at).to be_within(1.second).of(Time.now)
			end

			it { should respond_with 200 }
		end
	end

	describe "without a valid token", noToken: true do
		before(:each) { clearToken }

		describe "POST #create" do
			context "valid user information" do
				it "authenticates with a username" do
					post :create, username_or_email: user.username, password: user.password

					expect(json['api_key']['access_token']).to match /\S{32}/
					expect(json['api_key']['user_id']).to eq(user.id)
				end

				it "authenticates with an email address" do
					post :create, username_or_email: user.email, password: user.password

					expect(json['api_key']['access_token']).to match /\S{32}/
					expect(json['api_key']['user_id']).to eq(user.id)
				end
			end

			context "invalid user information" do
				it "doesn't authenticate" do
					post :create, username_or_email: user.email, password: 'definitelyWrongPassword'

					expect(response.status).to eq(401)
				end
			end
		end

  	describe "DELETE #destroy is unauthorized" do
  		before(:each) { delete :destroy }

  		it { should respond_with 401 }
  	end
	end
end
