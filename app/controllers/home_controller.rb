require 'rubygems'
require 'zip/zip'
require 'nanoc3'
require 'nanoc3/cli'
require 'nanoc3/cli/logger'

class HomeController < ApplicationController
	

	def index 	
	end 

	def commit 
		Resque.enqueue(UpdateDocs)
		# optional check  
		#redirect_to "/" if params[:payload].blank? 
	end 


end