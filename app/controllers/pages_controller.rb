class PagesController < ApplicationController
	def show
		@page = SpudPage.where(:url_name => params[:id])
	end
end
