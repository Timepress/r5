insert_into_file "#{@project_path}/config/environments/development.rb",
                 after: "config.cache_classes = false\n" do
  <<EOF
  # Setting to send development emails to mailcatcher (install mailcatcher gem) for easier testing
  config.action_mailer.default_url_options = { :host => 'localhost:3000'}
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {:address => "127.0.0.1", :port => 1025, domain: 'localhost'}
EOF
end

insert_into_file "#{@project_path}/config/environments/production.rb",
                 after: "config.cache_classes = true\n" do
  <<EOF
  config.action_mailer.default_url_options = { :host => "#{Config.settings['server']['name']}"}
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
      :address => "127.0.0.1",
      :port    => 25,
      :domain  => "#{Config.settings['server']['name']}"
  }
EOF
end
