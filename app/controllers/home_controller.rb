class HomeController < ApplicationController

require 'rubygems'
require 'zip/zip'

	def index 
	end 

	def commit 
		# optional check  
		redirect_to "/" if params[:payload].blank? 
		# Download the zip from git on a post request from GitHub
		open('rr.zip', 'wb') do |file|
  			file << open('https://github.com/mahil/rrr/zipball/master').read
		end
		# Extract the zip into a folder
		 Zip::ZipFile.open('public/rr.zip') { |zip_file|
   	  		zip_file.each { |f|
    	 f_path=File.join("public/docs", f.name)
     		FileUtils.mkdir_p(File.dirname(f_path))
     	zip_file.extract(f, f_path) unless File.exist?(f_path)
   		}
  	}
	end 

end