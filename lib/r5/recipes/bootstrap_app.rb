path = 'lib/tasks/bootstrap.rake'
bootstrap_file = "#{@project_path}/#{path}"
copy path

gsub_file bootstrap_file, 'ADMIN_LOGIN', Config.settings['admin']['login']
gsub_file bootstrap_file, 'ADMIN_PASSWORD', Config.settings['admin']['password']
gsub_file bootstrap_file, 'ADMIN_EMAIL', Config.settings['admin']['email']
gsub_file bootstrap_file, 'ADMIN_LASTNAME', Config.settings['admin']['lastname']


