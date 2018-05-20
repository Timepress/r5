gemfile = "#{@project_path}/Gemfile"
gsub_file gemfile, "gem 'sqlite3'", "gem 'mysql2'"

insert_into_file gemfile, after: "group :development, :test do\n" do
  <<EOF
  gem 'rspec-rails'
  gem 'factory_bot'
  gem 'timecop'
  gem 'guard-rspec'
  gem 'spring-commands-rspec'
EOF
end

begin
insert_into_file gemfile, after: "group :development do\n" do
  <<EOF
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'bullet'
  gem 'pry'
  gem 'pry-byebug'
EOF
end

end

append_to_file gemfile do
  <<EOF
group :test do
  gem 'faker'
  gem 'capybara'
end

# make content_tag temporarily available
gem 'record_tag_helper', '~> 1.0'
gem "jquery-rails"
# gem 'webpacker', '>= 4.0.x'
EOF
end

