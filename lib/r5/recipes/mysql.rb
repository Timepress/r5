#TODO add your own passwords
inside "#{@project_path}/config" do
  remove_file 'database.yml'
  create_file 'database.yml' do <<-EOF
development:
  adapter: mysql2
  encoding: utf8
  database: #{@project_name}
  pool: 5
  username: #{Config.settings['mysql']['user']}
  password: #{Config.settings['mysql']['password']}
  host: #{Config.settings['mysql']['host']}

test:
  adapter: mysql2
  encoding: utf8
  database: #{@project_name}_test
  pool: 5
  username: #{Config.settings['mysql']['user']}
  password: #{Config.settings['mysql']['password']}
  host: #{Config.settings['mysql']['host']}
  EOF
  end
end