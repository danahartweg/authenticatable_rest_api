namespace :db do

	desc "Fill database with sample data"
	task populate: :environment do

		5.times do |n|
			puts "[DEBUG] creating collection #{n+1} of 5"

			name = %w(Natural Manmade Synthetic Unknown Test).sample
			description = "Description for collection #{n+1}"

			Collection.create!( name: name,
													description: description )
		end

		Collection.all.each do |collection|
			20.times do |n|
				puts "[DEBUG] creating swatch #{n+1} of 20 for collection: #{collection.id}"

				name = %w(Cotton Wool Hemp Jute Ramie Kevlar).sample
				description = %w(new secondary testing best awesome supercalifragilistic).sample
				thumb_link = "http://placehold.it/100"
				img_link = "http://google.com"

				collection.swatches.create!( name: name,
																		 description: description,
																		 thumb_link: thumb_link,
																		 img_link: img_link )
			end
		end

	end
end
