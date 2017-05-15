add_gem 'bootstrap-generators'
add_gem 'bootstrap-select-rails'
add_gem 'scrollbar-rails'
run 'bundle install'
# TODO removing is probably not good idea when adding bootstrap to existing project
remove 'app/views/layouts/application.html.erb'
system "rails generate bootstrap:install"
sub "#{@project_path}/app/views/layouts/application.html.erb", "<%= favicon_link_tag 'favicon.png' %>", ""
sub "#{@project_path}/app/views/layouts/application.html.erb", /<title>.*?<\/title>/, "<title>#{@project_label}</title>"
sub "#{@project_path}/app/views/layouts/application.html.erb", /Project name/, @project_label
system "yarn add jquery"

sub "#{@project_path}/app/assets/javascripts/application.js",
    /require turbolinks/,
    "require turbolinks \n //= require jquery \n //= require jquery-ui"