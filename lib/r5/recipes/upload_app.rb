path = 'lib/tasks/upload.rake'
upload_file = "#{@project_path}/#{path}"
copy path

gsub_file upload_file, 'USER_NAME', Config.settings['server']['user']
gsub_file upload_file, 'PORT_NUMBER', Config.settings['server']['port']
gsub_file upload_file, 'PROD_SERVER', Config.settings['server']['name_prod']
gsub_file upload_file, 'STAGE_SERVER', Config.settings['server']['name_stage']


