class Collection < ActiveRecord::Base
	belongs_to :domain
	has_many :swatches
end
