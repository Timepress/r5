FileUtils.rm_rf("#{@project_path}/lib/templates")
my_directory 'lib/templates'
copy 'config/initializers/time_formats.rb'
