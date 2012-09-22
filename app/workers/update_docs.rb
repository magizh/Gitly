require 'rubygems'
require 'zip/zip'
require 'nanoc3'
require 'nanoc/cli'
require 'nanoc/cli/logger'


class UpdateDocs
  @queue = :docs_queue   
  def self.perform()
  	# Download the zip from git on a post request from GitHub
    open('rr.zip', 'wb') do |file|
  	  file << open('https://github.com/mahil/rrr/zipball/master').read
	end
	# remove previous files in content
 	FileUtils.rm_rf("content") 
 	FileUtils.rm_rf("static") 
 	FileUtils.rm_rf("public/data") 
 	mydir = []
	# Extract the zip into a folder
  	Zip::ZipFile.open('rr.zip') { |zip_file|
	 		zip_file.each { |f|
		 		f_path=File.join("public/docs", f.name)
				FileUtils.mkdir_p(File.dirname(f_path))
				  mydir << File.dirname(f_path)
				zip_file.extract(f, f_path) unless File.exist?(f_path)
			}
		}
   	FileUtils.mv(mydir[1]+'/content','content')
   	FileUtils.mv(mydir[1]+'/static','static')
   	FileUtils.mkdir_p('content/tags')
    # Run nanoc commands
    Nanoc::CLI.run(['tags'])
	Nanoc3::CLI.run(['compile'])
	# Remove downloaded repo
	FileUtils.rm_rf(mydir[1])
	FileUtils.mv('public/output/*','public')
  end
end