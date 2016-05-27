if yes? 'Do you want to prepare database config for mysql?'
  apply 'recipes/mysql.rb'
end

if yes? 'Do you want to add rspec generators to application.rb?'
  apply 'recipes/rspec_generators.rb'
end

if yes? 'Do you want to add exception notification?'
  apply 'recipes/exception_notification.rb'
end

if yes? 'do you want to drop and create a database?'
  rake 'db:drop'
  rake 'db:create'
end

if yes? 'Do you want to add devise to project?'
  apply 'recipes/devise.rb'
end