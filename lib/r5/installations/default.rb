# DEFAULT SETTINGS

# gsub_file "#{@project_path}/.ruby-version", /version/, RUBY_VERSION
apply 'recipes/gemfile.rb'
run 'bundle install'

# run 'bundle exec rails webpacker:install'
# system "yarn add @rails/webpacker@4.0.0-pre.2"
# system "yarn add webpack-cli -D"

copy 'config/initializers/html_helpers.rb'
copy 'config/locales/cs.yml'
copy 'app/assets/javascripts/custom.js'
copy 'app/assets/stylesheets/custom.css.scss'

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
apply 'recipes/materialize.rb'
layout_file = "#{@project_path}/app/views/layouts/application.html.erb"
remove 'app/views/layouts/application.html.erb'
copy 'app/views/layouts/application_materialize.html.erb', 'app/views/layouts/application.html.erb'
apply 'recipes/mail_settings.rb'
apply 'recipes/timepress_specifics.rb'
apply 'recipes/add_rack_mini_profiler.rb'
gsub_file layout_file, 'PROJECT_NAME', @project_name
apply 'recipes/gitignore.rb'
#copy '.ruby-version'
run 'git init'
run 'git add .'
run "git commit -a -m 'Initial commit'"

todo =
<<TEXT
Check mail configuration in config/environments/production.rb for your server
Check upload.rake task for your server
TEXT

say todo, :green
