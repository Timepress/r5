apply 'installations/default.rb'
# for testing project starter
run "rails g scaffold Article name:string body:text published_at:date"
rake "db:migrate"