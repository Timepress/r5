path = 'lib/tasks/upload.rake'
upload_file = "#{@project_path}/#{path}"
copy path

gsub_file upload_file, 'USER_NAME', Config.settings['server']['user']
gsub_file upload_file, 'PORT_NUMBER', Config.settings['server']['port']
gsub_file upload_file, 'SERVER_NAME', Config.settings['server']['name']


