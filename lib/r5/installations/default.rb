# DEFAULT SETTINGS
copy '.ruby-version'
gsub_file "#{@project_path}/.ruby-version", /version/, RUBY_VERSION
apply 'recipes/gemfile.rb'
run 'bundle check && bundle install'

copy 'config/initializers/html_helpers.rb'
copy 'config/locales/cs.yml'
copy 'app/assets/stylesheets/theme.css'
copy 'app/assets/stylesheets/custom.css.scss'
copy 'app/assets/stylesheets/timepress.css.scss'

my_directory 'app/assets/fonts'

remove 'app/views/layouts/application.html.erb'
copy 'app/views/layouts/application.html.erb'

apply 'recipes/bootstrap_app.rb'
apply 'recipes/upload_app.rb'
gsub_file "#{@project_path}/lib/tasks/upload.rake", /PROJECT_DIR/, @project_name

insert_into_file "#{@project_path}/config/application.rb",
                 after: "class Application < Rails::Application\n" do <<-RUBY
      config.assets.enabled = true
      config.assets.precompile += %w()
      config.i18n.default_locale = :cs
      config.time_zone = 'Prague'
RUBY
end

apply 'recipes/mysql.rb'
apply 'recipes/rspec_generators.rb'
apply 'recipes/exception_notification.rb'
rake 'db:drop'
rake 'db:create'

apply 'recipes/devise.rb'
apply 'recipes/bootstrap.rb'
layout_file = "#{@project_path}/app/views/layouts/application.html.erb"
remove 'app/views/layouts/application.html.erb'
copy 'app/views/layouts/application.html.erb'
apply 'recipes/mail_settings.rb'
gsub_file layout_file, 'PROJECT_NAME', @project_name
apply 'recipes/gitignore.rb'
run 'git init'
run 'git add .'
run "git commit -a -m 'Initial commit'"

todo =
<<TEXT
Check mail configuration in config/environments/production.rb for your server
Check upload.rake task for your server
TEXT

say todo, :green
