require 'rubygems'
require 'zip/zip'
require 'nanoc3'
require 'nanoc3/cli'
require 'nanoc3/cli/logger'

class HomeController < ApplicationController
	

	def index 	
	   Nanoc3::CLI.run(['tags'])
	   Nanoc3::CLI.run(['compile'])
	end 

	def commit 
		# optional check  
		#redirect_to "/" if params[:payload].blank? 
		# Download the zip from git on a post request from GitHub
		open('rr.zip', 'wb') do |file|
  			file << open('https://github.com/mahil/rrr/zipball/master').read
		end
		# # remove previous files in content
		 FileUtils.rm_rf("content") 
		 mydir = ""
		# # Extract the zip into a folder
		  	Zip::ZipFile.open('rr.zip') { |zip_file|
    	 		zip_file.each { |f|
     	 		f_path=File.join("public/docs", f.name)
      			FileUtils.mkdir_p(File.dirname(f_path))
      			
      			  mydir = File.dirname(f_path)
      			zip_file.extract(f, f_path) unless File.exist?(f_path)
    			}
   		}
   	File.rename(mydir,'public/docs/content')
   	FileUtils.mv('public/docs/content','content')
	end 


end