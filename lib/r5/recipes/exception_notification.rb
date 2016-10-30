add_gem 'exception_notification'

run 'bundle check && bundle install'

config_file = "#{@project_path}/config/initializers/exception_notification.rb"

run 'rails g exception_notification:install' unless File.exist? config_file
gsub_file config_file, "\"[ERROR] \"", "\"[#{@project_label} ERROR] \""
gsub_file config_file, "%{\"Notifier\" <notifier@example.com>},", "%{\"#{@project_label} Notifier\" #{Config.settings['notifier']['email']}},"
gsub_file config_file, "%w{exceptions@example.com}', '%w{#{Config.settings['notifier']['email']}}"