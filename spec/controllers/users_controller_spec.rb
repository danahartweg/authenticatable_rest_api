require 'spec_helper'

describe UsersController do

	describe "POST #create" do
		it "creates a new user when valid data is supplied" do
			post :create, user: FactoryGirl.attributes_for(:user)
			results = JSON.parse(response.body)

			results['api_key']['access_token'].should =~ /\S{32}/
			results['api_key']['user_id'].should > 0
		end

		it "shouldn't create a new user when invalid data is supplied" do
			post :create, user: FactoryGirl.attributes_for(:user, name: nil, username: nil)

			response.status.should == 422
		end
	end

	describe "PUT #update" do

		# password supplied by factory is password
		before :each do
			@user = FactoryGirl.create(:user, name: "Tester", username: "testinguser")
			@api_key = @user.find_api_key
			@old_digest_passsword = @user.password_digest
		end

		it "updates all user information" do
			put :update, { id: @user.id, user: FactoryGirl.attributes_for(:user, name: "New", username: "newusername", new_password: "newPassword", password_confirmation: "newPassword") }, { 'X-ACCESS-TOKEN' => "#{@api_key.access_token}" }

			@user.reload
			@user.name.should eq("New")
			@user.username.should eq("newusername")
			@user.password_digest.should_not eq @old_digest_passsword
			response.status.should == 200
		end

		it "updates all user information except password" do
			put :update, { id: @user.id, user: FactoryGirl.attributes_for(:user, name: "New", username: "newusername") }, { 'X-ACCESS-TOKEN' => "#{@api_key.access_token}" }

			@user.reload
			@user.name.should eq("New")
			@user.username.should eq("newusername")
			@user.password_digest.should eq @old_digest_passsword
			response.status.should == 200
		end

		it "doesn't update the user infomation when there is no password supplied" do
			put :update, { id: @user.id, user: FactoryGirl.attributes_for(:user, name: "New", username: "newusername", password: nil) }, { 'X-ACCESS-TOKEN' => "#{@api_key.access_token}" }

			@user.reload
			@user.name.should eq("Tester")
			@user.username.should eq("testinguser")
			response.status.should == 401
		end
	end

	describe "GET #show" do

		# password supplied by factory is password
		before :each do
			@user = FactoryGirl.create(:user, name: "Tester", username: "testinguser")
			@api_key = @user.find_api_key
			@old_digest_passsword = @user.password_digest
		end

		it "will show user information when a valid token is supplied" do
			get :show, { id: @user.id }, { 'X-ACCESS-TOKEN' => "#{@api_key.access_token}" }

			results = JSON.parse(response.body)
			results['user']['id'].should == @user.id
			results['user']['name'].should == @user.name
			response.status.should == 200
		end

		it "won't show user information with an invalid token" do
			get :show, { id: @user.id }, { 'X-ACCESS-TOKEN' => "#{SecureRandom.hex}" }

			response.status.should == 401
		end

		it "won't show user information without a token" do
			get :show, { id: @user.id }, { 'X-ACCESS-TOKEN' => "" }

			response.status.should == 401
		end

		it "won't show user information with an expired token" do
			@api_key.update_attribute(:expires_at, 365.days.ago)
			puts @api_key.expires_at
			get :show, { id: @user.id }, { 'X-ACCESS-TOKEN' => "#{@api_key.access_token}" }

			response.status.should == 401
		end

		it "won't show user information with a locked token" do
			@api_key.update_attribute(:is_locked, true)
			get :show, { id: @user.id }, { 'X-ACCESS-TOKEN' => "#{@api_key.access_token}" }

			response.status.should == 401
		end
	end

end
