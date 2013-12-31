require 'spec_helper'

describe UsersController do

	let(:user) { create(:user) }

	describe "with valid token", validToken: true do
		before(:each) { authWithUser(user) }

		describe "GET #show" do
			before(:each) { get :show }

			it "returns the information for the authenticated user" do
				expect(json).to have_key('user')
			end

			it { should respond_with 200 }
		end

		describe "PATCH #update" do
			let(:old_digest_passsword) { user.password_digest }

			context "valid attributes" do
				context "password supplied" do
					before :each do
						patch :update, user: attributes_for(:user, name: "Updated name", username: "updatedusername", new_password: "newPassword", password_confirmation: "newPassword")
						user.reload
					end

					it "updates its attributes" do
						expect(user.name).to eq("Updated name")
						expect(user.username).to eq("updatedusername")
					end

					it "updates password" do
						expect(user.password).to_not eq(old_digest_passsword)
					end

					it { should respond_with 204 }
				end

				context "no passsword supplied" do
					before :each do
						patch :update, user: attributes_for(:user, name: "Updated name", username: "updatedusername", password: nil)
						user.reload
					end

					it "doesn't update user information" do
						expect(user.name).to_not eq("Updated name")
						expect(user.username).to_not eq("updatedusername")
					end

					it { should respond_with 401 }
				end
			end

			context "invalid attributes" do
				before(:each) { patch :update, user: attributes_for(:user, name: nil) }

				it "has an error message" do
					expect(json).to have_key('errors')
				end

				it { should respond_with 422 }
			end
		end

		it "POST #create is unauthorized" do
  		post :create, user: attributes_for(:user)

  		expect(json).to have_key('errors')
  		expect(response.status).to eq(401)
  	end
	end

	describe "without a valid token", noToken: true do
		before(:each) { clearToken }

		describe "POST #create" do
			context "valid attributes" do
				before(:each) { post :create, user: attributes_for(:user) }


				it "returns the new user id" do
					expect(json['api_key']).to have_key('user_id')
				end

				it "returns the current login token" do
					expect(json['api_key']).to have_key('access_token')
				end

				it { should respond_with 201 }
			end

			context "invalid attributes" do
				before(:each) { post :create, user: attributes_for(:user, name: nil) }

				it "has an error message" do
					expect(json).to have_key('errors')
				end

				it { should respond_with 422 }
			end
		end

		it "GET #show is unauthorized" do
			get :show
			expect(response.status).to eq(401)
		end

  	it "PATCH #update is unauthorized" do
  		patch :update
  		expect(response.status).to eq(401)
  	end
	end
end
