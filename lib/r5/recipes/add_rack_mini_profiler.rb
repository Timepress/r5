if check_gem_existence 'rack-mini-profiler'
  say 'It seems you have already installed rack-mini-profiler gem, check your gemfile', :red
else
  add_gem 'rack-mini-profiler'
  run 'bundle install'
end
