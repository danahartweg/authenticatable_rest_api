require 'spec_helper'

describe User do
	let(:user) { create(:user) }
	subject { create(:user) }

	it { should be_valid }
	it { should validate_presence_of :name }
	it { should validate_presence_of :username }
	it { should validate_presence_of :email }
	it { should validate_uniqueness_of :username }
	it { should validate_uniqueness_of :email }

	it { should have_many :api_keys }

	describe "#find_api_key" do
		context "requested from web" do
			it "is an api key" do
				expect(user.find_api_key('web')).to be_an ApiKey
			end

			it "has the web scope" do
				expect(user.find_api_key('web').scope).to eq('web')
			end
		end

		context "requested from iOS" do
			it "is an api key" do
				expect(user.find_api_key('iOS')).to be_an ApiKey
			end

			it "has the iOS scope" do
				expect(user.find_api_key('iOS').scope).to eq('iOS')
			end
		end

		context "non-matching request" do
			it "is an api key" do
				expect(user.find_api_key).to be_an ApiKey
			end

			it "has the web scope" do
				expect(user.find_api_key.scope).to eq('web')
			end
		end
	end
end
