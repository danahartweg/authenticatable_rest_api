class Swatch < ActiveRecord::Base
	belongs_to :collection
	has_one :manufacturer
end
