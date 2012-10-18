class HomeController < ApplicationController

require 'rubygems'
require 'zip/zip'

	def index 
	end 

	def commit 
		# Download the zip from git on a post request from GitHub
		open('rr.zip', 'wb') do |file|
  			file << open('https://github.com/jacksoncvm/test/zipball/master').read
		end
		mydir = []
		FileUtils.rm_rf("public/content")
		# Extract the zip into a folder
		 Zip::ZipFile.open('rr.zip') { |zip_file|
   	  		zip_file.each { |f|
    	 f_path=File.join("public/content/", f.name)
    	 mydir << File.dirname(f_path)
     		FileUtils.mkdir_p(File.dirname(f_path))
     	zip_file.extract(f, f_path) unless File.exist?(f_path)
   		}
  	}
  	FileUtils.mv(mydir[1]+"/index.html",'public/')
	end 

end