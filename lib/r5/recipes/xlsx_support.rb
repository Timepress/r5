add_gem 'roo'
add_gem "axlsx" # problems with newest version of RubyZip
run 'bundle check && bundle install'
say 'For more information check:', :green
say 'https://github.com/randym/axlsx'
say 'https://github.com/roo-rb/roo'