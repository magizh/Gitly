require 'rubygems'
require 'zip/zip'
require 'nanoc3'
require 'nanoc/cli'
require 'nanoc/cli/logger'



class HomeController < ApplicationController	

	def index 	
		#FileUtils.mv('public/output/*','public')
		redirect_to '/getting-started.html'
	end 

	def commit 
		Resque.enqueue(UpdateDocs)
		# optional check  
		return 
	end 

end