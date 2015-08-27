class VisitorsController < ApplicationController
	require 'uri'
	respond_to :js

	def index
		@urls = Url.order(created_at: :desc)

	end

	def upload_url
		binding.pry
		if valid_url?(params[:url]) == 0
			@url = Url.new
			param_url = params[:url].match(/^http:\/\//) ? "#{params[:url]}" : "http:// + #{params[:url]}"
			@url.test_url = URI.parse("#{param_url}").host
			@url.save
		end
		@urls = Url.order(created_at: :desc)
	end

	def valid_url?(url)
		url =~ /^(http|https):\/\/|[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}(:[0-9]{1,5})?(\/.*)?$/ix
	end
end
