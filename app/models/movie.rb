class Movie < ActiveRecord::Base
	def self.movies(filter, sort_column)
		if filter != nil 
			self.where({:rating => filter.keys}).order(sort_column)
		else 
			self.order(sort_column)
		end
	end
	def self.getAllRatings
		self.pluck(:rating).uniq
	end
end
