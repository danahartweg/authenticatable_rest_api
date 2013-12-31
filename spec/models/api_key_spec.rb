require 'spec_helper'

describe ApiKey do
	let(:api_key) { build(:api_key) }
	subject { build(:api_key) }

	it { should be_valid }
	it { should validate_presence_of :user }
	it { should ensure_inclusion_of(:scope).in_array( %w[web iOS] ) }

	it { should belong_to :user }

	describe "#set_expiry_date" do
		context "with a scope of web" do
			let(:api_key) { create(:api_key, scope: 'web') }

			it "is one day" do
				expect(api_key.expires_at).to be_within(1.second).of(1.day.from_now)
			end
		end

		context "with a scope of iOS" do
			let(:api_key) { create(:api_key, scope: 'iOS') }

			it "is 30 days" do
				expect(api_key.expires_at).to be_within(1.second).of(30.days.from_now)
			end
		end
	end

	describe "#generate_access_token" do
		it "is a random hex string" do
			expect(api_key.access_token).to match /\S{32}/
		end
	end

	describe "#is_expired?" do
		context "with a date in the future" do
			let(:api_key) { build(:api_key, expires_at: 60.days.from_now) }

			it "is false" do
				expect(api_key.is_expired?).to be_false
			end
		end

		context "with a date in the past" do
			let(:api_key) { build(:api_key, expires_at: -60.days.from_now) }

			it "is true" do
				expect(api_key.is_expired?).to be_true
			end
		end
	end
end
