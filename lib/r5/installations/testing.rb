apply 'installations/default.rb'
# for testing project starter
run "rails g scaffold Article name:string body:text"
rake "db:migrate"