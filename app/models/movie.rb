class Movie < ActiveRecord::Base

	def self.movies(filters, sort_column)
		if filters != nil 
			self.where({:rating => filters}).order(sort_column)
		else 
			self.order(sort_column)
		end
	end

	def self.getAllRatings
		self.pluck(:rating).uniq
	end

	def self.set_options(params,session)
		setup = { :redirect => false }

		setup[:ratings] = if params[:ratings]
			
			if params[:ratings].kind_of? Hash
				params[:ratings].keys
			else
				params[:ratings]
			end

		elsif session[:ratings]
			setup[:redirect] = true
			session[:ratings]
		else
			self.getAllRatings
		end

		setup[:sort_column] = if params[:sort_column]
			params[:sort_column]
		elsif session[:sort_column]
			setup[:redirect] = true
			session[:sort_column]
		else
			nil
		end

		setup
	end
end
